output "apim_id" {
  description = "The ID of the API Management service"
  value       = azurerm_api_management.this.id
}

output "apim_name" {
  description = "The name of the API Management service"
  value       = azurerm_api_management.this.name
}

output "apim_gateway_url" {
  description = "The Gateway URL of the API Management service"
  value       = azurerm_api_management.this.gateway_url
}

output "api_ids" {
  description = "The IDs of all APIs"
  value       = { for k, v in azurerm_api_management_api.this : k => v.id }
}

output "subscription_ids" {
  description = "The IDs of all subscriptions"
  value       = { for k, v in azurerm_api_management_subscription.this : k => v.id }
}

output "backend_ids" {
  description = "The IDs of all backends"
  value       = { for k, v in azurerm_api_management_backend.this : k => v.id }
}

output "logger_ids" {
  description = "The IDs of all loggers"
  value       = { for k, v in azurerm_api_management_logger.this : k => v.id }
}

output "named_value_ids" {
  description = "The IDs of all named values"
  value       = { for k, v in azurerm_api_management_named_value.this : k => v.id }
}

output "apis" {
  description = "Map of APIs (name → config)"
  value       = var.apis
}
