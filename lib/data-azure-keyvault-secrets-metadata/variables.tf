variable "key_vault_name" {
  type        = string
  description = "The name of the key vault containing the secrets."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the key vault is located."
}

variable "secrets" {
  type = list(string)
  description = "The name of the secrets."
}
