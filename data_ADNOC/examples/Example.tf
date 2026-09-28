module "DATA" {
  source = "git::https://dev.azure.com/ThamamAI/ENERGY.AI/_git/energyai-terraform-modules-poc//modules/data_ADNOC?ref=data-adnoc"

  # get_private_DNS_zones = false  ## Default: true
  # get_subnets           = false  ## Default: true
  # environment = ""  ## Default: the value of the 'terraform.workspace' system variable
}
















###########################################################################
## Required providers (to pass TFLint checks)

terraform {
  required_version = ">= 1.10.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.20.0"
    }
  }
}
