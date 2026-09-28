output "id" {
  description = "User-Assigned Managed Identity resource ID"
  value       = azurerm_user_assigned_identity.this.id
}


output "name" {
  description = "User-Assigned Managed Identity name"
  value       = azurerm_user_assigned_identity.this.name
}


output "client_id" {
  description = "User-Assigned Managed Identity Client ID"
  value       = azurerm_user_assigned_identity.this.client_id
}


output "principal_id" {
  description = "User-Assigned Managed Identity Principal ID (Object ID)"
  value       = azurerm_user_assigned_identity.this.principal_id
}
