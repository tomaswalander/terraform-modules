output "cosmos_db_account_id" {
  description = "The ID of the created Azure CosmosDB Account."
  value       = azurerm_cosmosdb_account.this.id
}

output "cosmos_db_account_endpoint" {
  description = "The endpoint of the created Azure CosmosDB Account."
  value       = azurerm_cosmosdb_account.this.endpoint
}
