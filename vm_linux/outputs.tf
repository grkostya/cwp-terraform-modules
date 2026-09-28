output "id" {
  value = azurerm_linux_virtual_machine.this.id
}


output "identity" {
  value = azurerm_linux_virtual_machine.this.identity
}


output "name" {
  value = azurerm_linux_virtual_machine.this.name
}


output "computer_name" {
  value = azurerm_linux_virtual_machine.this.computer_name
}


output "private_ip_address" {
  value = azurerm_linux_virtual_machine.this.private_ip_address
}


output "os_disk_name" {
  value = azurerm_linux_virtual_machine.this.os_disk[0].name
}
