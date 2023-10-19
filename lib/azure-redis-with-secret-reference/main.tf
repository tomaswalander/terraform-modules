terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0"
    }
  }
}

locals {
  tags = merge(
    var.tags,
    {
      environment = var.environment
      owner       = var.owner
    }
  )
}

data "azurerm_key_vault" "this" {
  name                = var.key_vault_for_access_keys.key_vault_name
  resource_group_name = var.key_vault_for_access_keys.resource_group_name
}

resource "azurerm_redis_cache" "this" {
  name                = var.name
  
  location            = var.location
  resource_group_name = var.resource_group_name
  
  sku_name            = var.config.sku_name
  capacity            = var.config.capacity
  family              = var.config.sku_name == "Premium" ? "P": "C"
  
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  redis_version       = 6

  tags = local.tags
}

# Create an Azure Key Vault secret for the Redis Primary Access Key
resource "azurerm_key_vault_secret" "primary_connection_string_secret" {
  key_vault_id = data.azurerm_key_vault.this.id
  name         = "${var.name}-primary-connection-string"
  value        = azurerm_redis_cache.this.primary_connection_string

  tags         = local.tags

  lifecycle {
    ignore_changes = [
      content_type
    ]
  }
}

# Create an Azure Key Vault secret for the Redis Secondary Access Key
resource "azurerm_key_vault_secret" "secondary_connection_string_secret" {
  key_vault_id = data.azurerm_key_vault.this.id
  name         = "${var.name}-secondary-connection-string"
  value        = azurerm_redis_cache.this.secondary_connection_string

  tags         = local.tags
  
  lifecycle {
    ignore_changes = [
      content_type
    ]
  }
}