output "id" {
  value = azurerm_search_service.this.id
}

output "name" {
  value = azurerm_search_service.this.name
}

output "resource_group_name" {
  value = azurerm_search_service.this.resource_group_name
}

output "endpoint" {
  description = "The endpoint used to connect to this Search Service."
  value       = azurerm_search_service.this.endpoint
}

output "primary_key" {
  description = "The Primary Key used for Search Service Administration."
  value       = azurerm_search_service.this.primary_key
  sensitive   = true
}

output "secondary_key" {
  description = "The Secondary Key used for Search Service Administration."
  value       = azurerm_search_service.this.secondary_key
  sensitive   = true
}

output "query_keys" {
  description = "A list of query keys for the Search Service."
  value       = azurerm_search_service.this.query_keys
  sensitive   = true
}
