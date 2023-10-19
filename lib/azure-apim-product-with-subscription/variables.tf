variable "name" {
  type        = string
  description = "The name of the APIM Product"

  validation {
    condition     = can(regex("^[a-z-]+$", var.name))
    error_message = "The name can only contain lower case letters and hyphens."
  }
}

variable "display_name" {
  type        = string
  description = "The display name for the API Product."
}

variable "apim_resource_group_name" {
  type        = string
  description = "The name of the resource group where the APIM instance is."
}

variable "apim_name" {
  type        = string
  description = "The name of the APIM instance."
}

variable "main_subscription_primary_key" {
  type        = string
  description = "The primary subscription key of this product"
  sensitive   = true
}

variable "main_subscription_secondary_key" {
  type        = string
  description = "The secondary subscription key of this product"
  sensitive   = true
}

variable "subscriptions_limit" {
  type        = number
  description = "The maximum number of subscriptions allowed for this product."
  default     = 1

  validation {
    condition     = var.subscriptions_limit >= 1
    error_message = "The subscriptions_limit must be at least 1."
  }
}

variable "published" {
  type        = bool
  description = "Whether or not this product is published."
}

variable "state" {
  type        = string
  description = "The state of the APIM product's subscription."

  validation {
    condition     = contains(["active", "cancelled", "expired", "rejected", "submitted", "suspended"], var.state)
    error_message = "Allowed values for state are \"active\", \"cancelled\", \"expired\", \"rejected\", \"submitted\", \"suspended\"."
  }
}

