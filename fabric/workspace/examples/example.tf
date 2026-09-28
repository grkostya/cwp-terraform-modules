provider "azurerm" {
  features {}
  subscription_id = "ca6463e8-9a6e-4976-97ac-c506950a4e5f"
}

terraform {
  required_version = ">= 1.4.0"
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "1.1.0"
    }
  }
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

locals {
  env              = "stg"
  application_code = "msfabric"

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

# Workspace with Capacity and Identity
data "fabric_capacity" "this" {
  display_name = "example"

  lifecycle {
    postcondition {
      condition     = self.state == "Active"
      error_message = "Fabric Capacity is not in Active state. Please check the Fabric Capacity status."
    }
  }
}

module "fabric_workspace" {
  source = "../../workspace"

  fabric_ws_name     = "ws-${local.application_code}"
  fabric_capacity_id = data.fabric_capacity.this.id #(String) The ID of the Fabric Capacity to assign to the Workspace.

  fabric_users = [
    {
      principal = {
        id   = "11111111-1111-1111-1111-111111111111" # Replace with actual Object ID
        type = "User"                                 # User, Group, ServicePrincipal, ServicePrincipalProfile
      }
      role = "Admin" # Azure Roles: Admin, Member, Contributor
    },
  ]
  # Create Fabric lakehouse resource
  fabric_lh_name = "demo"
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
