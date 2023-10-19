variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where to keep the resource"
}

variable "location" {
  type        = string
  description = "The location of the resource group where to keep the resource"
}

variable "name" {
  type        = string
  description = "The name of the Azure Sql Server"

  validation {
    condition     = substr(var.name, 0, 6) == "redis-"
    error_message = "Name must start with redis-."
  }
}

variable "config" {
  type = object({
    sku_name = string
    capacity = number
  })
  description = "The configuration of the Redis Cache using settings for sku_name and capacity. For \"Basic\" and \"Standard\" capacity must be between 0 and 6 inclusive, and for \"Premium\" it must be between 1 and 4 inclusive. Currently this module does not allow for \"Premium\"."

  default = {
    sku_name = "Basic"
    capacity = 0
  }

  validation {
    condition     = contains(["Basic", "Standard"], var.config.sku_name)
    error_message = "Allowed values for sku_name are \"Basic\" or \"Standard\"."
  }
  validation {
    condition     = var.config.sku_name != "Basic" || (0 <= var.config.capacity && var.config.capacity <= 6)
    error_message = "For \"Basic \" sku capacity must be between 0 and 6."
  }
  validation {
    condition     = var.config.sku_name != "Standard" || (0 <= var.config.capacity && var.config.capacity <= 6)
    error_message = "For \"Standard \" sku capacity must be between 0 and 6."
  }
}

variable "key_vault_for_access_keys" {
  type        = object({
    key_vault_name      = string
    resource_group_name = string
  })
  description = "An existing Azure Key Vault where to store the Access Keys of the Redis instance."
}

variable "environment" {
  type        = string
  description = "The environment."
}

variable "owner" {
  type        = string
  description = "The owner."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to use for created resources"
}
