output "key_vault_id" {
  description = "The Azure resource Id of the key vault where the secrets are located"
  value       = data.azurerm_key_vault.this.id
}

output "secrets_meta_data" {
  description = "Meta data about the requested secrets. Note: The value is not exposed."
  sensitive   = true
  value       = local.secrets_out
}