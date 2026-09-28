resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location            = local.location
  resource_group_name = local.resource_group_name
  service_plan_id     = var.service_plan_id
  https_only          = true
  app_settings        = var.app_settings

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  site_config {
    application_stack {
      node_version = var.node_version
    }
  }

  dynamic "auth_settings_v2" {
    for_each = var.auth_settings_v2 != null ? [var.auth_settings_v2] : []
    content {
      require_authentication = auth_settings_v2.value.require_authentication
      unauthenticated_action = auth_settings_v2.value.unauthenticated_action
      default_provider       = auth_settings_v2.value.default_provider

      dynamic "active_directory_v2" {
        for_each = auth_settings_v2.value.active_directory_v2 != null ? [auth_settings_v2.value.active_directory_v2] : []
        content {
          client_id                       = active_directory_v2.value.client_id
          tenant_auth_endpoint            = active_directory_v2.value.tenant_auth_endpoint
          client_secret_setting_name      = active_directory_v2.value.client_secret_setting_name
          allowed_audiences               = active_directory_v2.value.allowed_audiences
          jwt_allowed_groups              = active_directory_v2.value.jwt_allowed_groups
          jwt_allowed_client_applications = active_directory_v2.value.jwt_allowed_client_applications
        }
      }

      login {
        token_store_enabled               = auth_settings_v2.value.login.token_store_enabled
        token_refresh_extension_time      = auth_settings_v2.value.login.token_refresh_extension_time
        preserve_url_fragments_for_logins = auth_settings_v2.value.login.preserve_url_fragments_for_logins
        cookie_expiration_convention      = auth_settings_v2.value.login.cookie_expiration_convention
        cookie_expiration_time            = auth_settings_v2.value.login.cookie_expiration_time
        validate_nonce                    = auth_settings_v2.value.login.validate_nonce
        nonce_expiration_time             = auth_settings_v2.value.login.nonce_expiration_time
      }
    }
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      sticky_settings,
      auth_settings_v2,
      app_settings["MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"],
      app_settings["WEBSITE_AUTH_AAD_ALLOWED_TENANTS"]
    ]
  }
}
