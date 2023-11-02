variable "namespace_name" {
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

variable "max_delivery_count" {
  type        = number
  description = "The maximum number of times an event will be retried."
}

variable "dead_lettering_on_filter_evaluation_error" {
  type        = bool
  description = "Whether or not to send the event to deadletter on filter evaluation error. Defaults to true."
  default     = true
}

variable "name" {
  type        = string
  description = "The name of the subscription to create. Must be unique within one Azure Servicebus topic."
  
  validation {
    condition     = substr(var.name, 0, 4) == "sbs-"
    error_message = "The subscription name must start with \"sbs-\"."
  }
}

variable "correlation_filters" {
  type = map(object({
    content_type        = optional(string)
    correlation_id      = optional(string)
    label               = optional(string)
    message_id          = optional(string)
    reply_to            = optional(string)
    reply_to_session_id = optional(string)
    session_id          = optional(string)
    to                  = optional(string)
    properties          = optional(map(string))
  }))
  description = "A map of correlation filters to create rules for which messages will be forwarded from the topic to the subscription. If left undefined or empty all messages will be forwarded. Defaults to {}."
  default     = {}
  
  validation {
    condition = alltrue([
      for name, filter in var.correlation_filters: anytrue([
        for key, value in filter: value != null
      ])
    ])
    error_message = "At least one of \"content_type\", \"correlation_id\", \"label\", \"message_id\", \"reply_to\", \"reply_to_session_id\", \"session_id\", \"to\" or \"properties\" must be set on every correlation_filter block."
  }
}
