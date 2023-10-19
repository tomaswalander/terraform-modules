# Provider configuration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
  backend "local" {
    path = ".terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  environment = "public"
}


#############################
# Basics                    #
#############################
module "rg" {
  source   = "../../lib/azure-resource-group"

  name     = "rg-tw-test-${var.test_run_unique_identifier}"
  location = "North Europe" 

  owner  = "tw-dx"
  
  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }
}


#############################
# APIM api, products, etc., #
#############################
# data "azurerm_api_management" "this" {
#   name                = "apim-devops-static-citests"
#   resource_group_name = "rg-tw-dev-static"
# }

# module "subscription_secrets" {
#   source = "../../lib/data-azure-keyvault-secrets-value"

#   key_vault_name      = "kv-devops-static-citests"
#   resource_group_name = "rg-tw-dev-static"
  
#   secrets = ["secret-one", "secret-two"]
# }

# module "apim_product" {
#   source   = "../../lib/azure-apim-product-with-subscription"

#   name         = "product-test-${var.test_run_unique_identifier}"
#   display_name = "Test product ${var.test_run_unique_identifier}"

#   apim_resource_group_name = data.azurerm_api_management.this.resource_group_name
#   apim_name                = data.azurerm_api_management.this.name
  
#   # need to use suffixes in tests as no two subscriptions is allowed the same subscription keys - irl scenarios should not do this.
#   main_subscription_primary_key   = "${module.subscription_secrets.secrets_data["secret-one"].value}-${var.test_run_unique_identifier}"
#   main_subscription_secondary_key = "${module.subscription_secrets.secrets_data["secret-two"].value}-${var.test_run_unique_identifier}"
  
#   published = false
#   state     = "active"
# }

# module "apim_api_from_open_api_with_product_assignment" {
#   source   = "../../lib/azure-apim-api-from-openapi-with-product-assignment"

#   name         = "api-swagger-${var.test_run_unique_identifier}"
#   display_name = "Test api swagger ${var.test_run_unique_identifier}"
  
#   base_path = "test-swagger-${var.test_run_unique_identifier}"

#   revision             = "1"
#   revision_description = "This is the first revision"

#   apim_resource_group_name = data.azurerm_api_management.this.resource_group_name
#   apim_name                = data.azurerm_api_management.this.name
  
#   open_api_spec_in_json  = file("${path.module}/swagger.json")
#   open_api_operation_ids = ["ping", "health"]

#   products = [
#     module.apim_product.apim_product_id
#   ]

#   depends_on = [
#     module.apim_product
#   ]
# }


#############################
# CosmosDB Account with SQL #
#############################
module "cosmosdb_account_with_sql" {
  source   = "../../lib/azure-cosmos-sqldbs"

  cosmosdb_account_name = "cosmos-${var.test_run_unique_identifier}"
  
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"

  consistency_policy = {
    consistency_level = "BoundedStaleness"
    max_interval_in_seconds = 600
    max_staleness_prefix    = 200000
  }

  capabilities = ["EnableAggregationPipeline"]

  failover_geo_locations = [{
    location = "West Europe"
  }]

  sql_databases = {
    "cosmos-sqldb-one" = {
      db_max_throughput = 1000
    }
    "cosmos-sqldb-two" = {
      db_max_throughput = 2000
    }
  }

  environment = "test"
  owner       = "tw-dx"

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg
  ]
}


#########
# Redis #
#########
module "redis" {
  source   = "../../lib/azure-redis-with-secret-reference"

  name = "redis-${var.test_run_unique_identifier}"
  
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"

  config = {
    sku_name = "Basic"
    capacity = 1
  }

  key_vault_for_access_keys = {
    key_vault_name      = "kv-devops-static-citests"
    resource_group_name = "rg-tw-dev-static" 
  }

  environment = "test"
  owner       = "tw-dx"

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg
  ]
}


###########################
# Private inbound traffic # 
###########################
module "app_private_inbound_traffic" {
  source   = "../../lib/azure-app-private-inbound-traffic"

  name = "pe-${var.test_run_unique_identifier}"

  app_resource_id     = azurerm_windows_function_app.this.id
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"

  subnet_id                            = azurerm_subnet.inbound.id
  private_dns_zone_resource_group_name = "rg-tw-dev-static"

  depends_on = [
    azurerm_subnet.inbound,
    azurerm_windows_function_app.this,
    module.rg
  ]

  environment = "test"
  owner       = "owner"

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }
}

#####################
# Static public IP  # 
#####################
module "app_public_ip" {
  source   = "../../lib/azure-app-outbound-static-ip"

  gateway_name    = "ng-${var.test_run_unique_identifier}"

  subnet_id       = azurerm_subnet.outbound.id
  app_resource_id = azurerm_windows_function_app.this.id
  
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"

  public_ip_name                = "pip-${var.test_run_unique_identifier}"
  public_ip_resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"

  environment = "test"
  owner       = "tw-dx"

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg,
    azurerm_subnet.outbound,
    azurerm_windows_function_app.this,
    azurerm_public_ip.this
  ]
}

########################################################################################
# The resource below are NOT part of the test but are needed to test other modules. In #
# "real life" usage of the tw-terraform-modules those could of course still have been #
# created using terraform - but not neccesarily the same tf process. I.e., in the eyes #
# of this test TF-process they are "static".                                           #
#                                                                                      #
# Currently tw-DX has no plans of providing them as terraform modules, but that could # 
# change. If they ever become modules the test will of course be updated accordingly.  #
########################################################################################

resource "azurerm_public_ip" "this" {
  name                = "pip-${var.test_run_unique_identifier}"
  
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"

  sku               = "Standard"
  sku_tier          = "Regional" 
  allocation_method = "Static"

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg
  ]
}

resource "azurerm_storage_account" "this" {
  name = "st${var.test_run_unique_identifier}"
  
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"
  
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg
  ]
}

resource "azurerm_service_plan" "this" {
  name                = "plan-${var.test_run_unique_identifier}"
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"
  os_type             = "Windows"
  sku_name            = "B1"

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg
  ]
}

resource "azurerm_windows_function_app" "this" {
  name    = "func-${var.test_run_unique_identifier}"
  
  location            = "North Europe"
  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"
  
  service_plan_id = azurerm_service_plan.this.id

  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  functions_extension_version = "4"
  builtin_logging_enabled     = false

  identity {
    type          = "SystemAssigned"
    identity_ids  = null
  }

  site_config {
    always_on                              = false
    app_scale_limit                        = 1

    application_stack {
      dotnet_version              = "v6.0"
      use_dotnet_isolated_runtime = true
    }
  }

  app_settings = merge(
    {
      WEBSITE_RUN_FROM_PACKAGE: 1
      ASPNETCORE_ENVIRONMENT:   "test",
      environment:              "test",
    }
  )

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg,
    azurerm_storage_account.this,
    azurerm_service_plan.this
  ]
}

resource "azurerm_virtual_network" "this" {
  name = "vnet-${var.test_run_unique_identifier}"

  resource_group_name = "rg-tw-test-${var.test_run_unique_identifier}"
  location            = "North Europe"

  address_space = ["10.0.0.0/8"]

  tags = {
    reason = "ci/cd,test"
    repo   = "tw-terraform-modules" 
  }

  depends_on = [
    module.rg
  ]
}

resource "azurerm_subnet" "inbound" {
  name = "snet-inbound-${var.test_run_unique_identifier}"

  resource_group_name  = "rg-tw-test-${var.test_run_unique_identifier}"
  virtual_network_name = "vnet-${var.test_run_unique_identifier}"

  address_prefixes = ["10.0.0.0/24"]

  depends_on = [
    module.rg,
    azurerm_virtual_network.this
  ]
}

resource "azurerm_subnet" "outbound" {
  name = "snet-outbound-${var.test_run_unique_identifier}"

  resource_group_name  = "rg-tw-test-${var.test_run_unique_identifier}"
  virtual_network_name = "vnet-${var.test_run_unique_identifier}"

  address_prefixes = ["10.0.1.0/24"]

  delegation {
    name = "func-app-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  depends_on = [
    module.rg,
    azurerm_virtual_network.this
  ]
}
