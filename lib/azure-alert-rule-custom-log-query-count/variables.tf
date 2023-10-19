variable "name" {
  type        = string
  description = "The name of the Alert Rule."

  validation {
    condition     = substr(var.name, 0, 3) == "ar-"
    error_message = "The alert rule name must start with 'ar-'."
  }
}

variable "description" {
  type        = string
  description = "A more descriptive text what the alert rule actually means. What you type here will greatly aid the Engineer On Call quickly graps what's going on."
}

variable "environment" {
  type        = string
  description = "The environment"
}

variable "application_insights" {
  type = object({
    id                  = string
    location            = string
    resource_group_name = string
  })
  description = "Information about the Azure Application Insights instance where to create the alert rule."
}

variable "action_group_ids" {
  type        = list(string)
  description = "A list of Action Group Ids where to send alerts from this rule."
}

variable "query" {
  type        = string
  description = "The query to use for monitoring. See examples here: https://registry.terraform.io/providers/hashicorp/azurerm/2.89.0/docs/resources/monitor_scheduled_query_rules_alert"
}

variable "severity" {
  type        = number
  description = "The severity level to use for fired alerts."
}

variable "operator" {
  type        = string
  description = "The operator to use for threshold comparison."

  validation {
    condition     = contains(["Equal", "GreaterThan", "GreaterThanOrEqual", "LessThan", "LessThanOrEqual"], var.operator)
    error_message = "Allowed values for operator are 'Equal', 'GreaterThan', GreaterThanOrEqual', 'LessThan', or 'LessThanOrEqual'."
  }
}

variable "threshold" {
  type        = number
  description = "The threshold for when the rule should fire an alert."
  default     = 5

  validation {
    condition     = 0 <= var.threshold && var.threshold <= 10000
    error_message = "The threshold must be between 0 and 10,000 inclusive."
  }
}

variable "frequency" {
  type        = number
  description = "The frequency for how often the rule should be evaluated in minutes."
  default     = 5

  validation {
    condition     = 5 <= var.frequency && var.frequency <= 1440
    error_message = "The frequency must be between 5 and 1,440 minutes inclusive."
  }
}

variable "time_window" {
  type        = number
  description = "The time window during with the rule threshold will be checked. Must be greater than or equal to the frequency."
  default     = 10

  validation {
    condition     = 5 <= var.time_window && var.time_window <= 2880
    error_message = "The tiem window must be between 5 and 2,880 minutes inclusive."
  }
}

variable "enabled" {
  type        = bool
  description = "Whether or not the alert rule is enabled."
  default     = true
}

variable "properties" {
  type        = map(string)
  description = "Additional properties to include in the Alert to help identify what's going on."
}

