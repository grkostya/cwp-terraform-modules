output "id" {
  description = "The ID of the Maps account."
  value       = azurerm_maps_account.this.id
}

output "name" {
  description = "The name of the Maps account."
  value       = azurerm_maps_account.this.name
}

output "maps_account_primary_key" {
  description = "The primary key of the Maps account."
  value       = azurerm_maps_account.this.primary_access_key
  sensitive   = true
}
