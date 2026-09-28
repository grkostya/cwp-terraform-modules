locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))
  uami_principal_id   = data.azurerm_client_config.this.object_id
}
