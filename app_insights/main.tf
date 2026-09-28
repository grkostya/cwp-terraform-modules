resource "azurerm_application_insights" "this" {
  name                = var.app_insights_name
  resource_group_name = local.resource_group_name
  location            = local.location
  workspace_id        = var.law_id
  tags                = local.tags
  application_type    = "web"
}
