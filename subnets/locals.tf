locals {
  nsg_resource_group_name = coalesce(try(var.nsg_resource_group.name, null), var.vnet.resource_group_name)

  location = coalesce(try(var.nsg_resource_group.location, null), var.vnet.location)

  tags = merge(coalesce(try(var.nsg_resource_group.tags, null), var.vnet.tags), var.additional_tags)
}
