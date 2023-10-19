variable "apim_product_id" {
  type        = string
  description = "The id of the Apim Product to connect to the subscription"
}

variable "display_name" {
  type        = string
  description = "The display name of the Apim Subscription."
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

variable "state" {
  type        = string
  description = "The state of the APIM product's subscription."

  validation {
    condition     = contains(["active", "cancelled", "expired", "rejected", "submitted", "suspended"], var.state)
    error_message = "Allowed values for state are \"active\", \"cancelled\", \"expired\", \"rejected\", \"submitted\", \"suspended\"."
  }
}

variable "allow_tracing" {
  type        = bool
  description = "Determines whether tracing can be enabled. Must not be allowed for any third party subscriptions."
  default     = false
}

