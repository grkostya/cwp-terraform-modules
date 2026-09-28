output "name" {
  value = azurerm_storage_account.this.name
}

output "id" {
  value = azurerm_storage_account.this.id
}

output "private_dns_zone" {
  value = try(azurerm_private_dns_zone.this[0], null)
}

output "connection_string_primary" {
  value = azurerm_storage_account.this.primary_connection_string
}

output "access_key_primary" {
  value = azurerm_storage_account.this.primary_access_key
}

output "connection_string_secondary" {
  value = azurerm_storage_account.this.secondary_connection_string
}

output "access_key_secondary" {
  value = azurerm_storage_account.this.secondary_access_key
}


output "resource_group_name" {
  value = azurerm_storage_account.this.resource_group_name
}
