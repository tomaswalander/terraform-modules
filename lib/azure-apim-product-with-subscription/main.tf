terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

resource "azurerm_api_management_product" "this" {
  product_id   = var.name
  display_name = var.display_name

  resource_group_name = var.apim_resource_group_name
  api_management_name = var.apim_name

  subscription_required = true
  approval_required     = true
  subscriptions_limit   = var.subscriptions_limit

  published = var.published
}

module "main_subscription" {
  source = "./../azure-apim-subscription"
  
  display_name = "${var.display_name} main subscription"
  apim_product_id   = azurerm_api_management_product.this.id

  state = var.state
  
  apim_resource_group_name = var.apim_resource_group_name
  apim_name = var.apim_name

  main_subscription_primary_key   = var.main_subscription_primary_key
  main_subscription_secondary_key = var.main_subscription_secondary_key
}
