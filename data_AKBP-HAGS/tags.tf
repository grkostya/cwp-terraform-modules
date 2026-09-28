data "azurerm_client_config" "current" {}

locals {
  tags = {
    CreatedBy        = data.azurerm_client_config.current.object_id
    Env              = upper(local.env)
    ManagedBy        = "Terraform"
    ProjectName      = "AKBP-HAGS"
    ProjectStartDate = "29.05.2026"
  }
}
