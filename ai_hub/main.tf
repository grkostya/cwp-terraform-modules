resource "azurerm_ai_services" "this" {
  name                = "aiservices-${var.name_suffix}"
  location            = local.location
  resource_group_name = local.resource_group_name
  sku_name            = var.sku
  tags                = local.tags

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.cmk_keyvault_key_uri != null ? [1] : []
    content {
      key_vault_key_id   = var.cmk_keyvault_key_uri
      identity_client_id = var.cmk_client_id
    }
  }

  custom_subdomain_name              = var.custom_subdomain_name
  fqdns                              = var.fqdns
  local_authentication_enabled       = var.local_authentication_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted
  public_network_access              = var.public_network_access

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []
    content {
      default_action = network_acls.value.default_action
      ip_rules       = network_acls.value.ip_rules
      virtual_network_rules {
        subnet_id                            = network_acls.value.virtual_network_rules[0].subnet_id
        ignore_missing_vnet_service_endpoint = network_acls.value.virtual_network_rules[0].ignore_missing_vnet_service_endpoint
      }
    }
  }

  dynamic "storage" {
    for_each = var.storage != null ? [var.storage] : []
    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = storage.value.identity_client_id
    }
  }
}



## Azure AI Hub
resource "azapi_resource" "hub" {
  type      = "Microsoft.MachineLearningServices/workspaces@2024-10-01-preview"
  name      = "aihub-${var.name_suffix}"
  location  = local.location
  parent_id = local.resource_group_id

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = local.user_assigned_identity_ids
  }

  body = {
    properties = {
      description    = "This is my Azure AI hub"
      friendlyName   = "My Hub"
      storageAccount = var.storage_account_id
      keyVault       = var.key_vault_id

      ## Optional
      applicationInsights = null
      containerRegistry   = null


      ## Optional: To enable Customer Managed Keys
      encryption = {
        status = local.hub_encryption_status
        keyVaultProperties = {
          keyVaultArmId    = var.key_vault_id
          keyIdentifier    = var.cmk_keyvault_key_uri
          identityClientId = var.cmk_client_id
        }
      }

    }
    kind = "Hub"
    tags = local.tags
  }
}




## AzAPI AI Services Connection
resource "azapi_resource" "AIServicesConnection" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview"
  name      = local.ai_services_connection_name
  parent_id = azapi_resource.hub.id

  body = {
    properties = {
      category      = "AIServices",
      target        = azurerm_ai_services.this.endpoint
      authType      = "AAD",
      isSharedToAll = true,
      metadata = {
        ApiType    = "Azure",
        ResourceId = azurerm_ai_services.this.id
      }
    }
  }
  response_export_values = ["*"]
}




# ## Azure AI Project
# resource "azapi_resource" "project" {
#   type      = "Microsoft.MachineLearningServices/workspaces@2024-04-01-preview"
#   name      = local.ai_project_name
#   location  = local.location
#   parent_id = local.resource_group_id

#   identity {
#     type = "SystemAssigned"
#   }

#   body = {
#     properties = {
#       description   = "This is my Azure AI PROJECT"
#       friendlyName  = "My Project"
#       hubResourceId = azapi_resource.hub.id
#     }
#     kind = "Project"
#     tags = local.tags
#   }
# }
