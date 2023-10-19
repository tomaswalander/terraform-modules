terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0"
    }
  }
}

locals {
  database_defaults = {
    db_max_throughput = 4000
  }  
}

resource "azurerm_cosmosdb_account" "this" {
  name                = var.cosmosdb_account_name
  
  location            = var.location
  resource_group_name = var.resource_group_name
  
  offer_type                = "Standard"         # only supported value
  kind                      = "GlobalDocumentDB" # sql dbs use this value
  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = var.consistency_policy.consistency_level
    max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy.max_staleness_prefix
  }

  dynamic "capabilities" {
    for_each = { for c in var.capabilities : c => { name: c } }
    iterator = capability
    content {
      name = capability.value.name
    }
  }

  geo_location {
    failover_priority = 0 
    location          = var.location
  }

  dynamic "geo_location" {
    for_each = { for k, v in var.failover_geo_locations: "${k}_${v.location}" => {
      priority = (k+1) # priority 0 is the primary location which uses the "location" variable.
      location = v.location
    } }
    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.priority
    }
  }

  tags = merge(
    var.tags,
    {
      owner       = var.owner
      environment = var.environment
    }
  )
}

resource "azurerm_cosmosdb_sql_database" "this" {
  for_each = var.sql_databases

  name                = each.key
  
  account_name        = azurerm_cosmosdb_account.this.name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name  

  autoscale_settings {
    max_throughput = each.value.db_max_throughput != null ? each.value.db_max_throughput : local.database_defaults.db_max_throughput
  }
}
