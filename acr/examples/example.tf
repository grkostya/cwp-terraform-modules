provider "azurerm" {
  features {}
  subscription_id = "f4ded157-4262-4495-b85c-d627f3acbe0a"
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}


locals {
  env = "dev"
  tags = merge(var.tags, {
    Environment = upper(local.env)
    ManagedBy   = "Terraform"
    Sovereignty = "Confidential"
  })
}

data "azurerm_resource_group" "this" {
  name = "{resource_group_name}"
}

data "azurerm_user_assigned_identity" "this" {
  name                = "{user_managed_identity_name}"
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault" "this" {
  name                = "{keyvault_name}"
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault_key" "this" {
  name         = "{key_name}"
  key_vault_id = data.azurerm_key_vault.this.id
}


module "naming" {
  source           = "../../../modules/naming"
  environment      = local.env
  application_code = "cv"
}


module "acr" {
  source                        = "../"
  name                          = replace(module.naming.azure.container_registry.name, "-", "")
  resource_group_name           = data.azurerm_resource_group.this.name
  location                      = data.azurerm_resource_group.this.location
  public_network_access_enabled = false ## Default: false
  export_policy_enabled         = false ## Default: false
  anonymous_pull_enabled        = false ## Default: false
  zone_redundancy_enabled       = false ## Default: false
  tags                          = local.tags
  identity = {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.this.id]
  }
  customer_managed_key = {
    key_vault_key_id                 = data.azurerm_key_vault_key.this.key_vault_id #  https://KV_NAME.vault.azure.net/keys/KEY_NAME/KEY_ID
    user_assigned_identity_id        = data.azurerm_user_assigned_identity.this.id
    user_assigned_identity_client_id = data.azurerm_user_assigned_identity.this.client_id
  }
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
