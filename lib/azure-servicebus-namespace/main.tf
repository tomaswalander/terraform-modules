terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

resource "azurerm_servicebus_namespace" "this" {
  name                = var.name

  location            = var.location
  resource_group_name = var.resource_group_name

  sku      = var.sku
  capacity = var.capacity

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
