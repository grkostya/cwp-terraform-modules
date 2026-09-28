provider "azurerm" {
  features {}
  subscription_id = "ca6463e8-9a6e-4976-97ac-c506950a4e5f"
}

variable "resource_group_name" {
  description = "Name of the Resource Group, this is precreated resource group"
  type        = string
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
  application_code = "msfabric"
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
  source           = "../../../modules/naming"
  environment      = local.env
  application_code = local.application_code
}

module "data" {
  source      = "../../../modules/data_ADNOC"
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
}

module "maps" {
  source = "../../../modules/maps_account"

  name                = module.naming.azure.maps_account.name
  resource_group_name = local.resource_group_name
  location            = var.location.name
  sku_name            = "S1"


  # cors = [
  #   { allowed_origins = ["https://example.com"] }
  # ]
  # data_store = [
  #   {
  #     storage_account_id = "..."
  #     unique_name        = "datastore01"
  #   }
  # ]
  # identity = {
  #   type         = "SystemAssigned"
  #   identity_ids = []
  # }
  local_authentication_enabled = true
  tags                         = local.tags
}

###########################################################################
### Required providers
###########################################################################
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.37.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.47.0"
    }
  }
}
