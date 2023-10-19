variable "name" {
  type        = string
  description = "The name of the PagerDuty service to create."
}

variable "escalation_policy_id" {
  type        = string
  description = "The ID of the PagerDuty escalation policy to use."
}

variable "business_service_id" {
  type        = string
  description = "The ID of the PagerDuty business service this service belongs to if applicable."
  default     = ""
}

variable "slack_channel_id" {
  type        = string
  description = "The ID of a slack channel where to connect the service alerts"
}