data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "this" {
  key_vault_id = data.azurerm_key_vault.this.id

  for_each     = toset(var.secrets)
  name         = each.key
}

locals {
  secrets_out = { for key, value in data.azurerm_key_vault_secret.this: 
    value.name => {
      ms_secret_ref       = "@Microsoft.KeyVault(VaultName=${var.key_vault_name};SecretName=${value.name})"
      content_type        = value.content_type
      secret_id           = value.id
      secret_name         = value.name
      version             = value.version
    }
  }
}