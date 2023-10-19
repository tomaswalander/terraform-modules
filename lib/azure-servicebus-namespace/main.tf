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
