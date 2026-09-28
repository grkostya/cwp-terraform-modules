resource "azurerm_network_security_group" "this" {
  name                = local.nsg_name
  location            = local.location
  resource_group_name = local.resource_group_name

  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                         = security_rule.key
      priority                     = security_rule.value["priority"]
      direction                    = security_rule.value["direction"]
      access                       = security_rule.value["access"]
      source_address_prefix        = security_rule.value["source_address_prefix"]
      source_address_prefixes      = security_rule.value["source_address_prefixes"]
      source_port_range            = security_rule.value["source_port_range"]
      source_port_ranges           = security_rule.value["source_port_ranges"]
      destination_address_prefix   = security_rule.value["destination_address_prefix"]
      destination_address_prefixes = security_rule.value["destination_address_prefixes"]
      destination_port_range       = security_rule.value["destination_port_range"]
      destination_port_ranges      = security_rule.value["destination_port_ranges"]
      protocol                     = security_rule.value["protocol"]
      description                  = security_rule.value["description"]
    }
  }

  tags = local.tags
}


resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.address_space
  tags                = local.tags
}


resource "azurerm_subnet" "default" {
  name                 = var.default_subnet.name
  resource_group_name  = azurerm_virtual_network.this.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.default_subnet.address_prefixes
  service_endpoints    = var.default_subnet.service_endpoints
}


resource "azurerm_subnet_network_security_group_association" "Default" {
  subnet_id                 = azurerm_subnet.default.id
  network_security_group_id = azurerm_network_security_group.this.id
}
