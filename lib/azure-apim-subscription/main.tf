terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

resource "azurerm_api_management_subscription" "this" {
  display_name = var.display_name
  product_id   = var.apim_product_id
  
  state = var.state
  
  resource_group_name = var.apim_resource_group_name
  api_management_name = var.apim_name

  primary_key    = var.main_subscription_primary_key
  secondary_key  = var.main_subscription_secondary_key

  allow_tracing = var.allow_tracing
}
