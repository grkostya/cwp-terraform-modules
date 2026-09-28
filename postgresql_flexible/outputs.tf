output "id" {
  value = azurerm_postgresql_flexible_server.this.id
}

output "name" {
  value = azurerm_postgresql_flexible_server.this.name
}

output "private_dns_zone" {
  value = try(azurerm_private_dns_zone.PostgreSQL_Flexible[0], null)
}

output "delegated_subnet_id" {
  value = try(azurerm_subnet.PostgreSQL_Flexible[0].id, null)
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}
