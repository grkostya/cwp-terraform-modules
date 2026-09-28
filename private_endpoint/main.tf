resource "azurerm_private_endpoint" "this" {
  name                          = local.name
  location                      = local.location
  resource_group_name           = local.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-${local.name}"
  tags                          = local.tags

  private_service_connection {
    name                           = local.name
    private_connection_resource_id = var.private_connection_resource.id
    subresource_names              = var.subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = var.private_connection_resource.name
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}
