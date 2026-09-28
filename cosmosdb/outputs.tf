output "id" {
  value = azurerm_cosmosdb_account.this.id
}

output "name" {
  value = azurerm_cosmosdb_account.this.name
}

output "resource_group_name" {
  value = azurerm_cosmosdb_account.this.resource_group_name
}

## CosmosDB endpoint (URI)
output "endpoint" {
  description = "The endpoint (URI) of the CosmosDB Account"
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "primary_key" {
  description = "The Primary Key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.this.primary_key
  sensitive   = true
}

output "secondary_key" {
  description = "The Secondary Key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.this.secondary_key
  sensitive   = true
}
