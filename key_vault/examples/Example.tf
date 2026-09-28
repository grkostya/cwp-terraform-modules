module "Key_Vault" {
  source = "../../../modules/key_vault"

  name           = "example"
  resource_group = "<resource_group_object>"
}
















###########################################################################
## Required providers (to pass TFLint checks)

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
  }
}
