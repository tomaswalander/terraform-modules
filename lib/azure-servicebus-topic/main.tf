data "azurerm_servicebus_namespace" "sb_namespace" {
  name                = var.namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_servicebus_topic" "sb_topic" {  
  name                = var.topic_name
  namespace_id        = data.azurerm_servicebus_namespace.sb_namespace.id

  # auto_delete_on_idle                   = TBD
  default_message_ttl                     = var.default_message_ttl
  duplicate_detection_history_time_window = var.duplicate_detection_history_time_window
  enable_batched_operations               = var.enable_batched_operations
  enable_express                          = var.enable_express
  enable_partitioning                     = var.enable_partitioning
}