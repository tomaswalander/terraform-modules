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

variable "webtest" {
  type = object({
    name                                     = string
    application_insights_id                  = string
    application_insights_resource_group_name = string
  })
  description = "Information about the WebTest to monitor and its parent Azure Application Insights instance."
}

variable "action_group_ids" {
  type        = list(string)
  description = "A list of Action Group Ids where to send alerts from this rule."
}

variable "environment" {
  type        = string
  description = "The environment"
}

variable "severity" {
  type        = number
  description = "The severity level to use for fired alerts."
}

variable "threshold" {
  type        = number
  description = "The threshold for when the rule should fire an alert."

  validation {
    condition     = 0 <= var.threshold && var.threshold < 100
    error_message = "The threshold must be in the range [0, 100[."
  }
}

variable "frequency" {
  type        = number
  description = "The frequency for how often the rule should be evaluated in minutes."
  default     = 1

  validation {
    condition     = 1 <= var.frequency && var.frequency <= 1440
    error_message = "The frequency must be between 5 and 1,440 minutes inclusive."
  }
}

variable "time_window" {
  type        = number
  description = "The time window during with the rule threshold will be checked. Must be greater than or equal to the frequency."
  default     = 5

  validation {
    condition     = 5 <= var.time_window && var.time_window <= 2880
    error_message = "The time window must be between 5 and 2,880 minutes inclusive."
  }
}

variable "properties" {
  type        = map(string)
  description = "Additional properties to include in the Alert to help identify what's going on."
}

