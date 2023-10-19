variable "name" {
  type        = string
  description = "The name of the Apim Api to create."
}

variable "display_name" {
  type        = string
  description = "The display name of the Api."
}

variable "base_path" {
  type        = string
  description = "The base path of the Api."
}

variable "revision" {
  type        = string
  description = "The revision of the Api."
}

variable "revision_description" {
  type        = string
  description = "A description of the revision of this Api."
  default     = ""
}

variable "apim_resource_group_name" {
  type        = string
  description = "The name of the resource group where the Apim instance is."
}

variable "apim_name" {
  type        = string
  description = "The name of the Apim instance."
}

variable "content" {
  type = object({
    kind     = string
    location = optional(string)
    value    = optional(string)
  })
  default = {
    kind     = "none"
    location = ""
    value    = ""
  }
  description = "The content of this api"

  # kind 
  validation {
    condition     = contains(["openapi", "swagger", "none"], var.content.kind)
    error_message = "The kind must be one of \"openapi\", \"swagger\" or \"none\"."
  }
  
  # location for kind none
  validation {
    condition     = var.content.kind != "none" || (var.content.location == null || var.content.location == "")
    error_message = "A location is not allowed when kind is none."
  }
  # value for kind none
  validation {
    condition     = var.content.kind != "none" || (var.content.value == null || var.content.value == "")
    error_message = "A value is not allowed when kind is none."
  }

  # location
  validation {
    condition     = var.content.kind == "none" || contains(["remote", "inline"], var.content.location)
    error_message = "When kind is not \"none\", location must be one of \"remote\" or \"inline\"."
  }
  
  # value for location
  validation {
    condition     = var.content == null || (var.content.location != "remote" || substr(var.content.value, 0, 4) == "http")
    error_message = "When location is \"remote\", value must be a remote url."
  }
}

variable "products" {
  type        = list(string)
  description = "A list of product ids to grant access to this Api."
}