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
  application_code = "speech"
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
}

module "cognitive_services" {
  source = "../../cognitive_services"

  resource_group_name = module.naming.azure.resource_group.name
  location            = var.location.name
  name                = "cognitive-service-${local.application_code}"

  kind     = "SpeechServices"
  sku_name = "S0"
  identity = {
    type = "SystemAssigned"
  }

  public_network_access_enabled = false
  custom_subdomain_name         = "mycustomspeechsubdomain"

  tags = local.tags
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
