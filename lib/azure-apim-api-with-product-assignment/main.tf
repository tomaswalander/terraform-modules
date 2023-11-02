terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

module "apim_api" {
  source = "../apim-api"

  name         = var.name
  display_name = var.display_name
  base_path    = var.base_path

  revision             = var.revision
  revision_description = var.revision_description

  apim_resource_group_name = var.apim_resource_group_name
  apim_name                = var.apim_name

  content = var.content
}

module "api" {
  source = "../apim-product-assignment"

  for_each = toset(var.products)

  apim_resource_group_name = var.apim_resource_group_name
  apim_name                = var.apim_name

  apim_api_name   = module.apim_api.name
  apim_product_id = each.value
}