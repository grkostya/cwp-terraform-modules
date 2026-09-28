provider "azurerm" {
  features {}
  subscription_id = "f4ded157-4262-4495-b85c-d627f3acbe0a"
}

variable "resource_group_name" {
  description = "Name of the Resource Group, this is precreated resource group"
  type        = string
  sensitive   = false
  nullable    = false
  default     = ""
}

variable "location" {
  type = object({
    name       = string
    short_name = string
  })
  default = {
    name       = "uaenorth"
    short_name = "aen"
  }
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

locals {
  env              = "stg"
  application_code = "databricks"
  tags = merge(var.tags, {
    Environment = upper(local.env)
    ManagedBy   = "Terraform"
    Sovereignty = "Confidential"
  })

  create_rg               = var.resource_group_name == ""
  resource_group_name     = local.create_rg ? module.naming.azure.resource_group.name : var.resource_group_name
  resource_group_location = local.create_rg ? var.location.name : data.azurerm_resource_group.this[0].location
}

module "naming" {
  source           = "../../naming"
  environment      = local.env
  application_code = local.application_code
}

module "data" {
  source      = "../../data_ADNOC"
  environment = local.env
}

data "azurerm_resource_group" "this" {
  count = local.create_rg ? 0 : 1
  name  = var.resource_group_name
}

# Create a resource group if exsiting resource group is not provided
resource "azurerm_resource_group" "this" {
  count    = local.create_rg ? 1 : 0
  name     = local.resource_group_name
  location = local.resource_group_location
  tags     = local.tags
}


module "key_vault" {
  source = "../../key_vault"

  name                = module.naming.azure.key_vault.name
  resource_group_name = azurerm_resource_group.this[0].name
  location            = var.location.name
  tags                = local.tags
}

module "databricks" {
  source = "../"

  adb_workspace_name  = module.naming.azure.databricks_workspace.name
  adb_managed_rg_name = "${module.naming.azure.resource_group.name}-managed"
  resource_group_name = module.naming.azure.resource_group.name
  location            = var.location.name

  tags = local.tags

  vnet_id = module.data.vnet_main.id

  adb_subnet_private_id   = module.data.snet_dbx_private.id
  adb_subnet_private_name = module.data.snet_dbx_private.name
  nsg_adb_private_id      = "/subscriptions/xxxxx/resourceGroups/my-network-rg/providers/Microsoft.Network/networkSecurityGroups/private-nsg"

  adb_subnet_public_id   = module.data.snet_dbx_public.id
  adb_subnet_public_name = module.data.snet_dbx_public.name
  nsg_adb_public_id      = "/subscriptions/xxxxx/resourceGroups/my-network-rg/providers/Microsoft.Network/networkSecurityGroups/public-nsg"

  adb_dbfs_key_vault_key_id             = "/subscriptions/xxxxx/resourceGroups/my-security-rg/providers/Microsoft.KeyVault/vaults/my-keyvault/keys/dbfs-key"
  managed_services_cmk_key_vault_key_id = "/subscriptions/xxxxx/resourceGroups/my-security-rg/providers/Microsoft.KeyVault/vaults/my-keyvault/keys/managed-services-key"
  managed_disk_cmk_key_vault_key_id     = "/subscriptions/xxxxx/resourceGroups/my-security-rg/providers/Microsoft.KeyVault/vaults/my-keyvault/keys/managed-disk-key"

  # Storage Account
  adb_storage_account_name = "mystorageaccount"

  # ADB Connector
  adb_connector_name = "databricks-connector-enai-stg-aen-001"
}



###########################################################################
### Required providers (to pass TFLint checks)
###########################################################################
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.47.0"
    }
  }
}
