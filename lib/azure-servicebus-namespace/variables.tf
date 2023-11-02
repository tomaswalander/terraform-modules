variable "name" {
  type        = string
  description = "The name of the resource"
}

variable "location" {
  type        = string
  description = "The location of the resource"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resource"
}

variable "sku" {
  type        = string
  description = "The SKU of the Service Bus namespace"
  default     = "Standard"
}

variable "capacity" {
  type        = number
  description = "The capacity of the Service Bus namespace"
  default     = 0
}

variable "tags" {
  type        = map(string)
  description = "A set of tags to assign to the resource"
  default     = {}
}