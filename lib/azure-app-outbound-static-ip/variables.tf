###########
# Network #
###########
variable "subnet_id" {
  type        = string
  description = "The Id of the subnet."
}

variable "gateway_name" {
  type        = string
  description = "The name of the gateway."

  validation {
    condition    = substr(var.gateway_name, 0, 3) == "ng-"
    error_message = "The gateway_name must start with \"ng-\"."
  }
}

#######
# App #
#######
variable "app_resource_id" {
  type        = string
  description = "The id of the app to give a public ip."
}

variable "location" {
  type        = string
  description = "The Azure region where the app exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group containing the App."
}

######
# IP #
######
variable "public_ip_name" {
  type        = string
  description = "The name of an existing public static ip to use"
}

variable "public_ip_resource_group_name" {
  type        = string
  description =  "The name of the resource group containing the existing public ip."
}

########
# Tags #
########
variable "environment" {
  type        = string
  description = "The environment."
}

variable "owner" {
  type        = string
  description = "The owner of any created resources."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to use for created resources."
  default     = {}
}