output "service_integration_webhook" {
  value =     "https://events.pagerduty.com/integration/${pagerduty_service_integration.azure_webhook.integration_key}/enqueue"
  description = "The webhook to use for sending events to this PagerDuty service"
}
