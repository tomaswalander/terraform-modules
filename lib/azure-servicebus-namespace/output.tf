output "id" {
  value       = azurerm_servicebus_namespace.this.id
  description = "The ID of the created Azure Servicebus Namespace"
}

output "endpoint" {
  value       = azurerm_servicebus_namespace.this.endpoint
  description = "The ID of the created Azure Servicebus Namespace"
}
