terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0"
    }
  }
}

locals {
  open_api_spec = jsondecode(var.open_api_spec_in_json)
  filtered_open_api_spec  = jsonencode({
    # Pass through general open api props
    swagger     = local.open_api_spec.swagger
    info        = local.open_api_spec.info
    host        = local.open_api_spec.host
    basePath    = local.open_api_spec.basePath
    schemes     = local.open_api_spec.schemes
    definitions = local.open_api_spec.definitions
    # Filter paths based on operation Id
    paths = {
      for path, path_config in local.open_api_spec.paths: path => {
        for http_method, method_config in path_config:
          http_method => method_config
          if contains(var.open_api_operation_ids, method_config.operationId)
      }
    }
  })
}

resource "azurerm_api_management_api" "this" {
  name         = var.name
  display_name = var.display_name

  revision             = var.revision
  revision_description = var.revision_description
  
  path = var.base_path

  resource_group_name = var.apim_resource_group_name
  api_management_name = var.apim_name
  
  protocols           = ["https"]

  # create import if content is specified
  import {
    content_format = "openapi+json"
    content_value  = local.filtered_open_api_spec
  }
}

resource "azurerm_api_management_product_api" "this" {
  for_each = toset(var.products)

  api_name            = azurerm_api_management_api.this.name
  product_id          = each.value
  
  api_management_name = var.apim_name
  resource_group_name = var.apim_resource_group_name
}
