output "id" {
  value       = azurerm_resource_group.this.id
  description = "The Azure Resource ID of the created resource group."
}

output "name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the created resource group"
}