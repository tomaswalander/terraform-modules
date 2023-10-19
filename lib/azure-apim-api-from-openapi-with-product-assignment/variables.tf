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

variable "open_api_spec_in_json" {
  type        = string
  description = "A json-encoded string containing an Open Api specification to use for creating the Api."
}

variable "open_api_operation_ids" {
  type        = list(string)
  description = "A list of operationIds from the OpenApi specification to include in this API. Non-existing opeartionIds will be silently ignored."
}

variable "products" {
  type        = list(string)
  description = "A list of product ids to grant access to this Api."
}