locals {
  vnet_name           = "vnet-enai-${local.env}-uaen-01"
  vnet_resource_group = "RG-ENAI-${upper(local.env)}-NETWORK-01"
}


data "azurerm_client_config" "current" {}


data "azurerm_resource_group" "Networking" {
  count = (var.get_subnets || var.get_private_DNS_zones || var.get_vnet_resource_group) ? 1 : 0

  name = local.vnet_resource_group
}


data "azurerm_virtual_network" "this" {
  count = (var.get_subnets || var.get_vnet) ? 1 : 0

  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group
}
