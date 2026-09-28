resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = local.location
  resource_group_name = local.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags                = local.tags
}
