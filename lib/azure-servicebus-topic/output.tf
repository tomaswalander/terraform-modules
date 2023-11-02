output "id" {
  value       = azurerm_servicebus_topic.sb_topic.id
  description = "The ID of the created Azure Servicebus topic."
}
