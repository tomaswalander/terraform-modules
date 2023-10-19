######################
# The app to protect #
######################
variable "app_resource_id" {
  type        = string
  description = "The id of the App."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group containing the App."
}
variable "location" {
  type        = string
  description = "The Azure region where the App exists."
}

######################
# Private endpoint   #
######################
variable "name" {
  type        = string
  description = "The name of the private endpoint to create"

  validation {
    condition     = substr(var.name, 0, 3) == "pe-" 
    error_message = "Must start with 'pe-'."
  }
}

######################
# Networking         #
######################
variable "subnet_id" {
  type        = string
  description = "The ID of the subnet for inbound traffic to this app."
}

variable "private_dns_zone_resource_group_name" {
  type        = string
  description = "The name of the resource group containing the Private DNS Zone."
}

######################
# Tags               #
######################
variable "environment" {
  type        = string
  description = "The environment"
}

variable "owner" {
  type        = string
  description = "The owner"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to use for created resources"
}
