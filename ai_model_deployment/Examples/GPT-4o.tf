module "GPT-4o" {
  source               = "../../../modules/ai_model_deployment"
  cognitive_account_id = "<cognitive_account_id>"
  name                 = "gpt-4o"

  model = {
    name    = "gpt-4o"
    version = "2024-11-20"
  }
  version_upgrade_option = "NoAutoUpgrade" ## Default: "OnceNewDefaultVersionAvailable"

  sku = {
    name     = "ProvisionedManaged"
    capacity = "50"
  }
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
