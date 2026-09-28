resource "azurerm_subnet" "this" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_address_prefixes
}


resource "azurerm_public_ip" "this" {
  name                = "pip-${var.name}"
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = merge(local.tags, { Associated_Resource = var.name })
}


resource "azurerm_bastion_host" "this" {
  name                = var.name
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = var.sku

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.this.id
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tunneling_enabled = var.tunneling_enabled
  tags              = local.tags
}
