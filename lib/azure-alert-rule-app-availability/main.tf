terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
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
}

resource "azurerm_monitor_metric_alert" "this" {
  name                = var.name
  description         = "[${upper(var.environment)}] ${local.prepared_description}"
  resource_group_name = var.webtest.application_insights_resource_group_name

  scopes = [
    var.webtest.application_insights_id
  ]

  window_size = "PT${var.time_window}M"
  frequency   = "PT${var.frequency}M"
  severity    = var.severity

  criteria {
    metric_namespace = "microsoft.insights/components"
    metric_name      = "availabilityResults/availabilityPercentage"
    aggregation      = "Average"
    operator         = "LessThanOrEqual"
    threshold        = var.threshold

    dimension {
      name     = "availabilityResult/name"
      operator = "Include"
      values = [
        var.webtest.name
      ]
    }
  }

  dynamic "action" {
    for_each = toset(var.action_group_ids)
    content {
      action_group_id = action.value
      webhook_properties = merge(
        var.properties,
        {
          environment = var.environment
        }
      )
    }
  }
}
