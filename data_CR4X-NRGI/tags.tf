data "azurerm_client_config" "current" {}

locals {
  tags = {
    CreatedBy        = data.azurerm_client_config.current.object_id
    Env              = upper(local.env)
    ManagedBy        = "Terraform"
    ProjectName      = "CR4X-NRGI"
    ProjectStartDate = "01.04.2026"
  }
}
