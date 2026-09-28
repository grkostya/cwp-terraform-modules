output "id" {
  value       = azurerm_service_plan.this.id
  description = "The ID of the App Service Plan."
}

output "name" {
  value       = azurerm_service_plan.this.name
  description = "The name of the App Service Plan."
}

output "resource_group_name" {
  value       = azurerm_service_plan.this.resource_group_name
  description = "The name of the resource group containing the App Service Plan."
}
