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
  env = "stg"
  tags = merge(var.tags, {
    Environment = upper(local.env)
    ManagedBy   = "Terraform"
    Sovereignty = "Confidential"
  })

  create_rg               = var.resource_group_name == ""
  resource_group_name     = local.create_rg ? module.naming.azure.resource_group.name : var.resource_group_name
  resource_group_location = local.create_rg ? var.location.name : data.azurerm_resource_group.this[0].location
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

module "naming" {
  source      = "../../naming"
  environment = local.env
}

module "data" {
  source      = "../../data_ADNOC"
  environment = local.env
}

module "function_app" {
  source = "../../../modules/function_app"

  resource_group_name          = module.naming.azure.resource_group.name
  location                     = var.location.name
  function_app_name            = module.naming.azure.function_app.name
  create_service_plan          = true
  existing_app_service_plan_id = null

  function_storage_account_name = "stgtest"

  swift_subnet_id   = ""
  app_insights_name = module.naming.azure.application_insights.name

  # If app_insights_name is provided, external values (connection_string and instrumentation_key) must not be provided.
  #application_insights_external = {
  #  connection_string    = "test"
  #  instrumentation_key  = "true"
  #}

  ## To use an existing private DNS zone. Default: type = "SystemAssigned", identity_ids = []
  # identity = {
  #   type         = "UserAssigned"
  #   identity_ids = [azurerm_user_assigned_identity.*.id]
  # }

  # settings for App Service Plan
  app_service_plan_name = module.naming.azure.app_service_plan.name
  service_plan_os_type  = "Linux"
  service_plan_sku      = "P2v3"
  tags                  = local.tags

}



# Create a Function App only using an existing Service Plan and App Service Environment
# module "function_app_existing" {
#   source              = "../../function_app"

#   resource_group_name        = module.naming.azure.resource_group.name
#   location                   = var.location.name
#   function_app_name          = "example-function-app"
#   service_plan_id            = "/subscriptions/xxxx/resourceGroups/rg-example/providers/Microsoft.Web/serverfarms/existing-plan"
#   app_service_environment_id = "/subscriptions/xxxx/resourceGroups/rg-example/providers/..."
#   tags                       = local.tags
# }


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
