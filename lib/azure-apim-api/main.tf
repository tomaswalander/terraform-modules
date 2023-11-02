terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

locals {
  content_format_maps = {
    openapi = {
      inline = "openapi+json"
      remote = "openapi+json-link"
    }
    swagger = {
      inline = "swagger-json"
      remote = "swagger-link-json"
    }
  }

  content_format = var.content.kind == "none" ? "" : local.content_format_maps[var.content.kind][var.content.location]
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
  dynamic "import" {
    for_each = var.content.kind == "none" ? {} : { "content": "dummy" }
    content {
      content_format = local.content_format
      content_value  = var.content.value
    }
  }
}
