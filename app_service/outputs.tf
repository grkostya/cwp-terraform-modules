output "id" {
  value       = azurerm_linux_web_app.this.id
  description = "The ID of the Linux Web App."
}

output "name" {
  value       = azurerm_linux_web_app.this.name
  description = "The name of the Linux Web App."
}

output "resource_group_name" {
  value       = azurerm_linux_web_app.this.resource_group_name
  description = "The name of the resource group containing the Linux Web App."
}

output "default_hostname" {
  value       = azurerm_linux_web_app.this.default_hostname
  description = "The default hostname of the Linux Web App."
}

output "identity" {
  value       = azurerm_linux_web_app.this.identity[0]
  description = "The system-assigned managed identity of the Linux Web App, including principal_id and tenant_id."
}
