variable "servicebus_namespace_name" {
  type        = string
  description = "The name of the Azure servicebus namespace"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group containing the Azure servicebus namespace"
}

variable "topic_name" {
  type        = string
  description = "The name of the Azure servicebus topic to create"
}

variable "default_message_ttl" {
  type        = string
  default     = "P1D"
  description = "The default TTL for messages sent to the Azure servicebus topic"
}

variable "duplicate_detection_history_time_window" {
  type        = string
  default     = "PT10M"
  description = "Duplicate detection time window"
}

variable "enable_batched_operations" {
  type        = bool
  default     = false
  description = "Enable partitioning for the Azure servicebus topic"
}

variable "enable_express" {
  type        = bool
  default     = false
  description = "Enable partitioning for the Azure servicebus topic"
}

variable "enable_partitioning" {
  type        = bool
  default     = false
  description = "Enable partitioning for the Azure servicebus topic"
}
