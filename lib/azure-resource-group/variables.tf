variable "name" {
  type        = string
  description = "The name of the resource group."
  
  validation {
    condition     = substr(var.name, 0, 3) == "rg-"
    error_message = "The resource group name must start with \"rg-\"."
  }
}

variable "location" {
  type        = string
  description = "The Azure location where to create the resource group."
}

variable "owner" {
  type        = string
  description = "The team or person owning this resource."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags which should be assigned to the Resource Group."
  default     = {}
}