terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">=2.6.2"
    }
  }
}

##########################
#     CREATE SERVICE     #
##########################
# service
resource "pagerduty_service" "this" {
  name                    = var.name
  auto_resolve_timeout    = "null"
  acknowledgement_timeout = "null" #setting this means every alert will move from acknowledged to re-triggered again after the specified time
  escalation_policy       = var.escalation_policy_id
  alert_creation          = "create_alerts_and_incidents"
}

# azure vendor integration
resource "pagerduty_service_integration" "azure_webhook" {
  name      = "Microsoft Azure Inbound"
  # type      = "events_api_v2_inbound_integration"
  service   = pagerduty_service.this.id
  vendor    = "PT6OIQO"
}

# Add business service dependency to new service
resource "pagerduty_service_dependency" "this" {
  dependency {
    dependent_service {
      id   = var.business_service_id
      type = "business_service"
    }
    supporting_service {
      id   = pagerduty_service.this.id
      type = "service"
    }
  }
  count = var.business_service_id != "" ? 1 : 0
}

############################
# connect service to slack #
############################
locals {
  priorities = {
    P1 = {
      id = "PUOTA4K"
    }
    P2 = {
      id = "PQC5ZSX"
    }
    P3 = {
      id = "PN2HYD7"
    }
    P4 = {
      id = "P6TWY0H"
    }
    P5 = {
      id = "P2H8XOU"
    }
  }
  slack_events = [
      "incident.triggered",
      "incident.reassigned",
      "incident.escalated",
      "incident.resolved",

      # The below events are being evaluated whether or not we actually want them.
      "incident.unacknowledged",
      "incident.delegated",
      "incident.priority_updated",
      "incident.responder.added",
      "incident.responder.replied",
      "incident.status_update_published",
      "incident.reopened"

      # not used
      # "incident.acknowledged",
    ]
}

# "No priority" and "Any priority" are interpreted differently in PagerDuty.
# So, we need to setup to forwards for every service to catch all alerts.

# Events with any priority
resource "pagerduty_slack_connection" "slack" {
  source_id         = pagerduty_service.this.id
  source_type       = "service_reference"
  notification_type = "responder"

  # workspace_id sourced from SLACK_CONNECTION_WORKSPACE_ID
  channel_id   = var.slack_channel_id
  
  config {
    events = local.slack_events
    # Forward events for all priorities
    # priorities = [ for k, v in local.priorities: v.id ]
  }
}
