locals {
  env = lower(terraform.workspace)

  # Determine if this is the development environment
  is_dev_env = contains(regex("^(?:.*(dev))?.*$", terraform.workspace), "dev")
}




module "JUMPBOX" {
  count = local.is_dev_env ? 0 : 1

  source = "../../../modules/vm_linux"

  vm_name        = "vm-jumpbox-${local.env}"
  resource_group = azurerm_resource_group.this
  subnet_id      = azurerm_subnet.default-subnet.id
  vm_size        = "Standard_B2ats_v2"
  admin_username = "azureuser"
  ssh_keys       = "<SSH KEY>"
}


resource "azurerm_role_assignment" "this" {
  count = local.is_dev_env ? 0 : 1

  scope                = "<RESOURCE ID>"
  role_definition_name = "<ROLE"
  principal_id         = module.JUMPBOX[0].vm_identity[0].principal_id
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
