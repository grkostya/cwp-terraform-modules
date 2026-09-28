locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))
  tags                = merge(var.tags, try(var.resource_group.tags, null))
}
