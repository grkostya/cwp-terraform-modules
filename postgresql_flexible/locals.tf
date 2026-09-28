locals {
  # Either to create a pirvate cluster, or public
  delegated_subnet_id           = try(coalesce(var.existing_delegated_subnet_id, azurerm_subnet.PostgreSQL_Flexible[0].id), null)
  public_network_access_enabled = local.delegated_subnet_id == null ? true : false

  # Either to create a pirvate DNS zone
  create_private_dns_zone = (var.delegated_subnet == null && var.private_endpoint_subnet_id == null) || var.existing_private_dns_zone_id != null ? false : true

  private_dns_zone_name = var.delegated_subnet == null ? "privatelink.postgres.database.azure.com" : "${var.name}.private.postgres.database.azure.com"

  private_dns_zone_id = var.delegated_subnet != null ? try(var.existing_private_dns_zone_id, azurerm_private_dns_zone.PostgreSQL_Flexible[0].id, null) : try(var.existing_private_dns_zone_id, null)

  vnet_id = try(split("/subnet", try(azurerm_subnet.PostgreSQL_Flexible[0].id, var.private_endpoint_subnet_id))[0], null)

  vnet_name = try(split("virtualNetworks/", local.vnet_id)[1], null)

  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))

  location = coalesce(var.location, try(var.resource_group.location, null))

  # Generate rules for the 'var.firewall_rule_CIDRs' in a format:
  #    name (e.g. 1-1-1-0_24) = {
  #      start_ip_address = "1.1.1.0"
  #      end_ip_address   = "1.1.1.255"
  #    }
  #
  firewall_rules_from_CIDRs = { for address in var.firewall_rule_CIDRs :
    replace(replace(address, "/", "_"), ".", "-") => {
      start_ip_address = try(cidrhost(address, 0), address)
      end_ip_address   = try(cidrhost(address, -1), address)
    }
  }

  firewall_rules = merge(var.firewall_rules, try(local.firewall_rules_from_CIDRs, {}))
}
