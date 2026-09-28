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
  source           = "../../../naming"
  environment      = local.env
  application_code = local.application_code
}

module "data" {
  source      = "../../../data_ADNOC"
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


module "fabric_capacity" {
  source = "../../capacity"

  resource_group_name = module.naming.azure.resource_group.name
  location            = var.location.name
  tags                = local.tags

  fabric_capacity_name       = "fc${local.application_code}"
  fabric_capacity_sku        = "F2"                                     # Valid values are: [ 'F2', 'F4', 'F8', 'F16', 'F32', 'F64', 'F128', 'F256', 'F512', 'F1024', 'F2048' ]
  fabric_capacity_admin_upns = ["00000000-0000-0000-0000-000000000000"] # Replace with actual identifiers
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
    fabric = {
      source  = "microsoft/fabric"
      version = "1.1.0"
    }
  }
}
