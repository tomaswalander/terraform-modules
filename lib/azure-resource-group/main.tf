terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location

  tags = merge(
    var.tags,
    {
      created_by        = "terraform"
      tf_azurerm_version   = "3.75.0"
      owner             = var.owner
    }
  )
}
