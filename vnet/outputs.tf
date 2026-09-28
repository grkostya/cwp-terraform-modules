output "id" {
  description = "The Virtual Network resource id"
  value       = azurerm_virtual_network.this.id
}


output "vnet_name" {
  value = azurerm_virtual_network.this.name
}


output "vnet_resource_group_name" {
  value = azurerm_virtual_network.this.resource_group_name
}


output "subnet_id" {
  value = azurerm_subnet.default.id
}


output "nsg_id" {
  value = azurerm_network_security_group.this.id
}


output "nsg_name" {
  value = azurerm_network_security_group.this.name
}
