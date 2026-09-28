resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet.resource_group_name
  virtual_network_name = var.vnet.name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints

  dynamic "delegation" {
    for_each = var.delegation == null ? [] : [var.delegation]
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = lookup(delegation.value.service_delegation, "actions", [])
      }
    }
  }

  lifecycle {
    ignore_changes = [private_link_service_network_policies_enabled]
  }
}




###########################################################################
###  Route table association

resource "azurerm_subnet_route_table_association" "this" {
  for_each = var.use_udr ? toset(["udr"]) : []

  subnet_id      = azurerm_subnet.this.id
  route_table_id = var.route_table_id
}




###########################################################################
###  NSG

resource "azurerm_network_security_group" "this" {
  name                = "nsg-${azurerm_subnet.this.name}"
  location            = local.location
  resource_group_name = local.nsg_resource_group_name
  tags                = local.tags
}


resource "azurerm_network_security_rule" "this" {
  for_each = var.nsg_rules

  name                         = each.key
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = try(each.value.source_port_range, null)
  source_port_ranges           = try(each.value.source_port_ranges, null)
  destination_port_range       = try(each.value.destination_port_range, null)
  destination_port_ranges      = try(each.value.destination_port_ranges, null)
  source_address_prefix        = try(each.value.source_address_prefix, null)
  source_address_prefixes      = try(each.value.source_address_prefixes, null)
  destination_address_prefix   = try(each.value.destination_address_prefix, null)
  destination_address_prefixes = try(each.value.destination_address_prefixes, null)
  description                  = try(each.value.description, null)

  network_security_group_name = azurerm_network_security_group.this.name
  resource_group_name         = local.nsg_resource_group_name
}


resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}
