locals {
  # Handle the case when the 'private_endpoint' variable doesn't contain a value for 'existing_private_dns_zone_name'
  # (e.g., private_endpoint = null)
  existing_private_dns_zone_name = try(var.private_endpoint.existing_private_dns_zone.name, null)

  # Define whether to create a new private DNS zone
  create_new_private_dns_zone = var.private_endpoint != null && local.existing_private_dns_zone_name == null ? true : false

  # Either get the ID of the newly created private DNS zone, or try to get the ID of an existing zone
  private_dns_zone_group_id = local.create_new_private_dns_zone ? azurerm_private_dns_zone.this[0].id : try(data.azurerm_private_dns_zone.this[0].id, null)

  # Either the newly created private DNS zone object, or the data source object, or 'null' for public storage accounts
  private_dns_zone = try(azurerm_private_dns_zone.this[0], data.azurerm_private_dns_zone.this[0], null)

  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))

  location = coalesce(var.location, try(var.resource_group.location, null))

  ## Format name
  name = format("%.24s", replace(var.name, "-", ""))


  identity = var.customer_managed_key == null ? var.identity : {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = setunion(var.identity.identity_ids, toset([var.customer_managed_key.user_assigned_identity_id]))
  }

}
