# Create App Service Plan only if an existing plan ID is not provided
resource "azurerm_service_plan" "this" {
  count               = var.create_service_plan ? 1 : 0
  name                = var.app_service_plan_name
  location            = local.location
  resource_group_name = local.resource_group_name
  os_type             = var.service_plan_os_type == "Linux" ? "Linux" : "Windows"
  sku_name            = var.service_plan_sku
  tags                = local.tags
  #app_service_environment_id = local.app_service_environment_id #"I2v2"
}

# Create Linux Function App
resource "azurerm_linux_function_app" "this" {
  name                = var.function_app_name
  location            = local.location
  resource_group_name = local.resource_group_name

  storage_uses_managed_identity = true

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  # Use existing App Service Plan if provided, otherwise create a new one
  service_plan_id = local.computed_service_plan_id

  # Public network access is disabled for the Function App
  public_network_access_enabled = false
  https_only                    = true

  storage_account_name = var.function_storage_account_name
  #storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  site_config {
    application_stack {
      python_version = "3.11"
    }
    # Use external Application Insights values if provided;
    # otherwise, if the resource is created, use its values.
    application_insights_connection_string = local.computed_ai_connection_string
    application_insights_key               = local.computed_ai_key

    dynamic "cors" {
      for_each = length(var.cors_allowed_origins) > 0 ? [1] : []
      content {
        allowed_origins     = var.cors_allowed_origins
        support_credentials = var.cors_support_credentials
      }
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME   = "python"
    WEBSITE_BASIC_AUTH_ENABLED = "true"
  }

  tags = local.tags

  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app#storage_key_vault_secret_id-1:~:text=NOTE%20on%20regional%20virtual%20network%20integration%3A
  lifecycle {
    ignore_changes = [app_settings, virtual_network_subnet_id, tags["hidden-link: /app-insights-resource-id"]]
  }
}

##Function  App Vnet intergration
resource "azurerm_app_service_virtual_network_swift_connection" "netwrok_integration" {
  app_service_id = azurerm_linux_function_app.this.id
  subnet_id      = var.swift_subnet_id
}

resource "azurerm_application_insights" "this" {
  count               = local.ai_count
  name                = var.app_insights_name
  location            = local.location
  resource_group_name = local.resource_group_name
  workspace_id        = var.law_id
  application_type    = "web"
  tags                = local.tags
}
