output "apim_subscription_id" {
  description = "The ID of the created APIM Subscription."
  value = azurerm_api_management_subscription.this.id
}
