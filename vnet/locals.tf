locals {
  nsg_name = coalesce(var.nsg_name, "${var.vnet_name}-NSG")

  nsg_rules = var.nsg_rules == null ? {} : var.nsg_rules

  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))

  location = coalesce(var.location, try(var.resource_group.location, null))

  tags = coalesce(var.tags, try(var.resource_group.tags, null))
}
