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
  })
}




data "azurerm_resource_group" "this" {
  name = "{resource_group_name}"
}




module "naming" {
  source           = "../../../modules/naming"
  environment      = local.env
  application_code = "cv"
}




module "log_analytics_workspace" {
  source                     = "../../../modules/log_analytics_workspace"
  name                       = module.naming.azure.log_analytics_workspace.name
  resource_group_name        = data.azurerm_resource_group.this.name
  location                   = data.azurerm_resource_group.this.location
  sku                        = "PerGB2018" ## Default: "PerGB2018"
  retention_in_days          = 90          ## Default: 30
  internet_ingestion_enabled = false       ## Default: false
  internet_query_enabled     = false       ## Default: false
  tags                       = local.tags  ## Default: null
}








###########################################################################
### Required providers (to pass TFLint checks)
###########################################################################
terraform {
  required_version = ">= 1.4.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.13.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "{subscription_id}"
}
