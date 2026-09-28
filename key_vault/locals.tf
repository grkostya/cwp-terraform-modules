locals {
  key_vault_name = format("%.24s", replace(var.name, "-", ""))

  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))

  tenant_id = coalesce(var.tenant_id, data.azurerm_client_config.current.tenant_id)
}
