output "ai_services_id" {
  description = "The ID of the AI Services Account."
  value       = azurerm_ai_services.this.id
}

output "ai_services_endpoint" {
  description = "The endpoint used to connect to the AI Services Account."
  value       = azurerm_ai_services.this.endpoint
}

output "primary_access_key" {
  description = "The primary access key for the AI Services Account."
  value       = azurerm_ai_services.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the AI Services Account."
  value       = azurerm_ai_services.this.secondary_access_key
  sensitive   = true
}

output "identity" {
  description = "The identity block of the AI Services Account."
  value       = azurerm_ai_services.this.identity
}
