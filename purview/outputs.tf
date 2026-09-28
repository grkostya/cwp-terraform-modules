output "id" {
  value = azurerm_purview_account.this.id
}

output "name" {
  value = azurerm_purview_account.this.name
}

output "principal_id" {
  value = try(azurerm_purview_account.this.identity[0].principal_id, "")
}

output "managed_resource_group_name" {
  value = azurerm_purview_account.this.managed_resource_group_name
}

output "managed_resources" {
  value = azurerm_purview_account.this.managed_resources
}

output "azurerm_purview_account" {
  value = azurerm_purview_account.this
}
