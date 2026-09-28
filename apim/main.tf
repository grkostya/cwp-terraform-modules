# APIM Service
resource "azurerm_api_management" "this" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email

  sku_name = var.sku_name

  identity {
    type = "SystemAssigned"
  }

  virtual_network_type = var.virtual_network_type
  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  min_api_version = "2019-12-01" # Required for policy support
}

# Key Vault Role Assignment for APIM
# This allows APIM to read secrets from Key Vault for named values
resource "azurerm_role_assignment" "apim_key_vault" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_api_management.this.identity[0].principal_id
}

# APIM Loggers
# Supports Application Insights and other logger types
resource "azurerm_api_management_logger" "this" {
  for_each = { for k, v in var.loggers : k => v if v.type != "azureMonitor" }

  name                = each.key
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
  buffered            = lookup(each.value, "buffered", true)

  # Application Insights logger configuration
  dynamic "application_insights" {
    for_each = each.value.type == "applicationInsights" ? [1] : []
    content {
      instrumentation_key = each.value.credentials.instrumentation_key
    }
  }

  resource_id = lookup(each.value, "resource_id", null)
}

# APIM Named Values (Secrets/Configuration)
# These can be referenced in policies as {{value-name}}
resource "azurerm_api_management_named_value" "this" {
  for_each = var.named_values

  name                = each.value.name
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name
  display_name        = each.value.display_name
  secret              = each.value.secret

  # Link to Key Vault secrets for secure storage
  dynamic "value_from_key_vault" {
    for_each = each.value.key_vault_secret ? [1] : []
    content {
      secret_id = "${var.key_vault_uri}secrets/${each.value.name}"
    }
  }

  depends_on = [azurerm_role_assignment.apim_key_vault]
}

# APIM Backends
# Backends represent the actual services that APIs proxy to
# Uses Bearer token authentication to satisfy Azure Policy requirements
resource "azurerm_api_management_backend" "this" {
  for_each = var.backends

  name                = each.key
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name
  protocol            = each.value.protocol
  url                 = each.value.url

  # Credentials configuration using Bearer token authentication
  # This satisfies the Azure Policy requiring authenticated backend calls
  # Named values like {{backend-name}} are substituted with actual secrets from Key Vault
  dynamic "credentials" {
    for_each = lookup(each.value, "credentials", null) != null ? [each.value.credentials] : []
    content {
      authorization {
        scheme    = credentials.value.authorization.scheme
        parameter = credentials.value.authorization.parameter
      }
    }
  }
}

# APIM APIs
# Defines the API interfaces exposed through APIM
resource "azurerm_api_management_api" "this" {
  for_each = var.apis

  name                  = each.key
  resource_group_name   = var.resource_group_name
  api_management_name   = azurerm_api_management.this.name
  revision              = "1"
  display_name          = each.value.display_name
  path                  = each.value.path
  protocols             = each.value.protocols
  service_url           = lookup(each.value, "service_url", null)
  subscription_required = each.value.subscription_required

  # Import OpenAPI specification for API definition
  dynamic "import" {
    for_each = lookup(each.value, "openapi_spec_content", null) != null ? [1] : []
    content {
      content_format = "openapi+json"
      content_value  = file(each.value.openapi_spec_content)
    }
  }

  # Configure how subscription keys are passed
  dynamic "subscription_key_parameter_names" {
    for_each = lookup(each.value, "subscription_key_parameter_names", null) != null ? [1] : []
    content {
      header = each.value.subscription_key_parameter_names.header
      query  = each.value.subscription_key_parameter_names.query
    }
  }
}

# APIM API Policies
# Defines the processing logic for API requests/responses
resource "azurerm_api_management_api_policy" "this" {
  for_each = { for k, v in var.apis : k => v if lookup(v, "policy_file", null) != null }

  api_name            = each.key
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name

  xml_content = file(each.value.policy_file)

  # Ensure all dependencies are created before applying policies
  depends_on = [
    azurerm_api_management_api.this,
    azurerm_api_management_backend.this,
    azurerm_api_management_named_value.this
  ]
}

# APIM Global Policy
# Default policy applied to all APIs (can be overridden by API-specific policies)
resource "azurerm_api_management_policy" "global" {
  api_management_id = azurerm_api_management.this.id

  xml_content = <<XML
<policies>
  <inbound />
  <backend>
    <forward-request />
  </backend>
  <outbound />
</policies>
XML
}

# APIM Users
# User management for developer portal (optional)
resource "azurerm_api_management_user" "this" {
  for_each = var.users

  user_id             = each.key
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
  email               = each.value.email
  first_name          = each.value.first_name
  last_name           = each.value.last_name
  state               = each.value.state
}

# APIM Subscriptions
# API subscription keys for client applications
resource "azurerm_api_management_subscription" "this" {
  for_each = var.subscriptions

  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name
  display_name        = each.value.display_name
  state               = each.value.state
  allow_tracing       = lookup(each.value, "allow_tracing", false)

  # CRITICAL: Use the name as subscription_id instead of auto-generated GUID
  subscription_id = each.value.name

  # Use api_id to scope the subscription to a specific API
  # Fixed: Single-line ternary operator
  api_id = lookup(each.value, "api_name", null) != null ? "${azurerm_api_management.this.id}/apis/${each.value.api_name}" : null

  # Fixed: depends_on with proper reference to the API map
  depends_on = [azurerm_api_management_api.this]
}

# APIM API Diagnostics
# Configure logging and monitoring for APIs
resource "azurerm_api_management_api_diagnostic" "this" {
  for_each = { for k, v in var.diagnostics : k => v if lookup(v, "api_name", null) != null }

  identifier               = each.value.identifier
  resource_group_name      = var.resource_group_name
  api_management_name      = azurerm_api_management.this.name
  api_name                 = each.value.api_name
  api_management_logger_id = azurerm_api_management_logger.this[each.value.logger_name].id

  sampling_percentage = each.value.sampling_percentage
  always_log_errors   = true
  log_client_ip       = true
  verbosity           = "information"

  # Request/response logging configuration
  frontend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  frontend_response {
    body_bytes     = 0
    headers_to_log = []
  }

  backend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  backend_response {
    body_bytes     = 0
    headers_to_log = []
  }
}
