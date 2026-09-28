resource "azurerm_cognitive_deployment" "this" {
  cognitive_account_id   = var.cognitive_account_id
  name                   = var.name
  rai_policy_name        = var.rai_policy_name
  version_upgrade_option = var.version_upgrade_option

  model {
    format  = var.model.format
    name    = var.model.name
    version = var.model.version
  }

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    size     = var.sku.size
    family   = var.sku.family
    capacity = var.sku.capacity
  }
}
