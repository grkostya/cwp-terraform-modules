locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))

  name = var.name == null ? "pe-${var.private_connection_resource.name}" : "pe-${var.name}"
}
