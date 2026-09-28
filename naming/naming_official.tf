# module "naming" {
#   source                 = "Azure/naming/azurerm"
#   version                = ">=0.4.2"
#   suffix                 = compact([local.app_code, local.subscription_code, local.env, local.location, var.number])
#   unique-include-numbers = var.unique-include-numbers
#   unique-seed            = var.unique-seed
#   unique-length          = var.unique-length
# }


## Using the cloned version (Source: https://github.com/Azure/terraform-azurerm-naming)
module "naming" {
  # source = "git::https://dev.azure.com/aiqeai/EnergyAI/_git/clone-terraform-azurerm-naming?ref=0.4.3"
  source = "git::https://github.com/Azure/terraform-azurerm-naming?ref=0.4.3"

  suffix                 = compact([local.app_code, local.subscription_code, local.env, local.location, var.number])
  unique-include-numbers = var.unique-include-numbers
  unique-seed            = var.unique-seed
  unique-length          = var.unique-length
}
