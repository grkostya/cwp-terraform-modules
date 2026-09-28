

resource "azurerm_private_dns_zone" "this" {
  count = local.create_new_private_dns_zone ? 1 : 0

  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.resource_group_name
  tags                = local.tags
}

## If an existing DNS zone provided, reference the zone
data "azurerm_private_dns_zone" "this" {
  count = local.existing_private_dns_zone_name == null ? 0 : 1

  name                = local.existing_private_dns_zone_name
  resource_group_name = try(var.private_endpoint.existing_private_dns_zone.resource_group_name, local.resource_group_name)
}


resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each           = try(var.private_endpoint.virtual_networks, {})
  name               = each.key
  virtual_network_id = each.value.id

  resource_group_name   = local.private_dns_zone.resource_group_name
  private_dns_zone_name = local.private_dns_zone.name
}


resource "azurerm_private_endpoint" "this" {
  count = var.private_endpoint != null ? 1 : 0

  name                          = "pe-${azurerm_storage_account.this.name}"
  location                      = local.location
  resource_group_name           = local.resource_group_name
  subnet_id                     = var.private_endpoint.subnet_id
  custom_network_interface_name = "nic-pe-${azurerm_storage_account.this.name}"

  private_service_connection {
    name                           = "pe-${azurerm_storage_account.this.name}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_storage_account.this.name
    private_dns_zone_ids = [local.private_dns_zone_group_id]
  }

  tags = azurerm_storage_account.this.tags
}
