output "vm_id" {
  value = azurerm_windows_virtual_machine.this.id
}


output "vm_identity" {
  value = azurerm_windows_virtual_machine.this.identity
}
