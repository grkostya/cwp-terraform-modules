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
  env                       = "dev"
  vnet_name                 = "vnet_name"
  vnet_resource_group       = "vnet_resource_group_name"
  ml_workspaces_subnet_name = "ml_workspace_subnet_name"
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

data "azurerm_storage_account" "this" {
  name                = "{ml_storage_account_name}"
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_container_registry" "this" {
  name                = "{container_registry_name}"
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "this" {
  name                 = local.ml_workspaces_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group
}

data "azurerm_application_insights" "this" {
  name                = "{application_insights_name}"
  resource_group_name = data.azurerm_resource_group.this.name
}

module "naming" {
  source           = "../../../../modules/naming"
  environment      = local.env
  application_code = "cv"
}

module "mlw" {
  source                       = "../"
  workspace_name               = module.naming.azure.machine_learning_workspace.name
  application_insights_id      = data.azurerm_application_insights.this.id
  resource_group_name          = data.azurerm_resource_group.this.name
  location                     = data.azurerm_resource_group.this.location
  key_vault_id                 = data.azurerm_key_vault.this.id
  tags                         = local.tags
  storage_account_id           = data.azurerm_storage_account.this.id
  container_registry_id        = data.azurerm_container_registry.this.id
  serverless_compute_subnet_id = data.azurerm_subnet.this
  identity = {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.this.id]
  }
  customer_managed_key = {
    key_vault_key_id          = data.azurerm_key_vault_key.this.id #  https://KV_NAME.vault.azure.net/keys/KEY_NAME/KEY_ID
    user_assigned_identity_id = data.azurerm_user_assigned_identity.this.id
    key_vault_id              = data.azurerm_key_vault.this.id
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
