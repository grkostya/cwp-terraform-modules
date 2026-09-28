output "id" {
  description = "The ID of the Cognitive Services account."
  value       = azurerm_cognitive_account.this.id
}

output "name" {
  description = "The name of the Cognitive Services account."
  value       = azurerm_cognitive_account.this.name
}

output "cognitive_account_endpoint" {
  description = "The endpoint URL of the Cognitive Services account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "identity" {
  description = "The Cognitive Services Identity."
  value       = azurerm_cognitive_account.this.identity
}

output "location" {
  description = "The location of the Cognitive Services account."
  value       = azurerm_cognitive_account.this.location
}

output "cognitive_account_primary_access_key" {
  description = "The primary access key of the Cognitive Services account."
  value       = azurerm_cognitive_account.this.primary_access_key
  sensitive   = true
}

output "cognitive_account_secondary_access_key" {
  description = "The secondary access key of the Cognitive Services account."
  value       = azurerm_cognitive_account.this.secondary_access_key
  sensitive   = true
}
