terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

resource "azurerm_api_management_product_api" "this" {
  api_name            = var.apim_api_name
  product_id          = var.apim_product_id
  api_management_name = var.apim_name
  resource_group_name = var.apim_resource_group_name
}
