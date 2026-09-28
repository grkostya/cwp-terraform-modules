## OUTBOUND TO THE INTERNET: Allow outbound traffic to the internet for all destinations.
## This rule is created by default for NSGs. You must not override it with a manual 'Deny' rule
## to ensure smooth operations of your application gateway.
## Outbound NSG rules that deny any outbound connectivity must not be created.
## See: https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure#network-security-groups




resource "azurerm_network_security_rule" "AppGw-Subnet" {
  count = var.create_NSG_rules ? 1 : 0

  name                       = "Allow-AppGw-Subnet"
  priority                   = 1001
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  source_address_prefix      = var.NSG_allowed_sources == null ? "*" : null
  source_address_prefixes    = var.NSG_allowed_sources == null ? null : var.NSG_allowed_sources
  destination_address_prefix = var.subnet.address_prefix
  destination_port_ranges    = ["80", "443"]

  network_security_group_name = var.NSG.name
  resource_group_name         = var.NSG.resource_group_name
}


resource "azurerm_network_security_rule" "FrontendIPs" {
  count = (var.create_NSG_rules && var.public_ip != null) ? 1 : 0

  name                       = "Allow-FrontendIPs"
  priority                   = 1002
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  source_address_prefix      = "Internet"
  destination_address_prefix = try(var.public_ip.ip_address, "")
  destination_port_ranges    = ["80", "443"]

  network_security_group_name = var.NSG.name
  resource_group_name         = var.NSG.resource_group_name
}


resource "azurerm_network_security_rule" "GatewayManager" {
  count = var.create_NSG_rules ? 1 : 0

  name                       = "Allow-GatewayManager"
  priority                   = 1003
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "65200-65535"
  source_address_prefix      = "GatewayManager"
  destination_address_prefix = "*"

  network_security_group_name = var.NSG.name
  resource_group_name         = var.NSG.resource_group_name
}


## This rule is present by default in the NSG
# resource "azurerm_network_security_rule" "AzureLoadBalancer" {
#   count = var.create_NSG_rules ? 1 : 0

#   name                       = "Allow-AzureLoadBalancer"
#   priority                   = 1004
#   direction                  = "Inbound"
#   access                     = "Allow"
#   protocol                   = "*"
#   source_port_range          = "*"
#   destination_port_range     = "*"
#   source_address_prefix      = "AzureLoadBalancer"
#   destination_address_prefix = "*"

#   network_security_group_name = var.NSG.name
#   resource_group_name         = var.NSG.resource_group_name
# }


# resource "azurerm_network_security_rule" "Deny-Rest-Inbound" {
#   count = var.create_NSG_rules ? 1 : 0

#   name                       = "Deny-Rest-Inbound"
#   priority                   = 4000
#   direction                  = "Inbound"
#   access                     = "Deny"
#   protocol                   = "*"
#   source_port_range          = "*"
#   destination_port_range     = "*"
#   source_address_prefix      = "*"
#   destination_address_prefix = "*"

#   network_security_group_name = var.NSG.name
#   resource_group_name         = var.NSG.resource_group_name
# }
