resource "azurerm_servicebus_subscription" "subscription" {
  name                = var.name

  topic_id = var.topic_id
  
  max_delivery_count                        = var.max_delivery_count
  dead_lettering_on_filter_evaluation_error = var.dead_lettering_on_filter_evaluation_error
}

resource "azurerm_servicebus_subscription_rule" "correlation_filter_rules" {
  for_each = var.correlation_filters

  name        = each.key
  filter_type = "CorrelationFilter"

  subscription_id = azurerm_servicebus_subscription.subscription.id
  
  correlation_filter {
    content_type        = lookup(each.value, "content_type", null)
    correlation_id      = lookup(each.value, "correlation_id", null)
    label               = lookup(each.value, "label", null)
    message_id          = lookup(each.value, "message_id", null)
    reply_to            = lookup(each.value, "reply_to", null)
    reply_to_session_id = lookup(each.value, "reply_to_session_id", null)
    session_id          = lookup(each.value, "session_id", null)
    to                  = lookup(each.value, "to", null)
    properties          = lookup(each.value, "properties", null)
  }
}
