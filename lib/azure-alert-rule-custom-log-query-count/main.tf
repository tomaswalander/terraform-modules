terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0"
    }
  }
}

locals {
  prepared_description = replace(
    replace(
      replace(
        var.description,
        "{env}",
      var.environment),
      "{threshold}",
      var.threshold
    ),
    "{time_window}",
    var.time_window
  )
  prepared_query = replace(
    replace(
      replace(
        var.query,
        "{env}",
      var.environment),
      "{threshold}",
      var.threshold
    ),
    "{time_window}",
    var.time_window
  )
}

resource "azurerm_monitor_scheduled_query_rules_alert" "test" {
  name        = var.name
  description = "[${upper(var.environment)}]: ${local.prepared_description}"

  location            = var.application_insights.location
  resource_group_name = var.application_insights.resource_group_name

  action {
    action_group = var.action_group_ids
    custom_webhook_payload = jsonencode(merge(
      var.properties,
      {
        environment : var.environment
      }
    ))
  }

  data_source_id = var.application_insights.id

  enabled = var.enabled

  query       = local.prepared_query
  frequency   = var.frequency
  time_window = var.time_window

  severity = var.severity

  trigger {
    operator  = var.operator
    threshold = var.threshold
  }
}