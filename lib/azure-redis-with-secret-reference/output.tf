output "id" {
  description = "The ID of the created Azure Redis resource"
  value       = azurerm_redis_cache.this.id
}

output "redis_primary_connection_string" {
  description = "Information to retrieve the primary connection string of the Azure Redis instance from the provided key vault."
  value = {
    secret_id      = azurerm_key_vault_secret.primary_connection_string_secret.id
    secret_name    = azurerm_key_vault_secret.primary_connection_string_secret.name
    ms_secret_ref  = "@Microsoft.KeyVault(VaultName=${data.azurerm_key_vault.this.name};SecretName=${azurerm_key_vault_secret.primary_connection_string_secret.name})"
  }
}

output "redis_secondary_connection_string" {
  description = "Information to retrieve the secondary connection string of the Azure Redis instance from the provided key vault."
  value = {
    secret_id      = azurerm_key_vault_secret.secondary_connection_string_secret.id
    secret_name    = azurerm_key_vault_secret.secondary_connection_string_secret.name
    ms_secret_ref  = "@Microsoft.KeyVault(VaultName=${data.azurerm_key_vault.this.name};SecretName=${azurerm_key_vault_secret.secondary_connection_string_secret.name})"
  }
}