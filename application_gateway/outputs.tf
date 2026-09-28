output "id" {
  value = azurerm_application_gateway.this.id
}


output "name" {
  value = azurerm_application_gateway.this.name
}


output "private_ip_address" {
  value = azurerm_application_gateway.this.frontend_ip_configuration[0].private_ip_address
}


output "public_ip_address_id" {
  value = azurerm_application_gateway.this.frontend_ip_configuration[0].public_ip_address_id
}
