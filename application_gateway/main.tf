resource "azurerm_application_gateway" "this" {
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  ###############################################################
  ### Application Gateway with all optional blocks

  sku {
    name     = var.sku.name ## Default: "Standard_v2"
    tier     = var.sku.name
    capacity = var.autoscale_configuration == null ? var.sku.capacity : null ## Default: 2
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration[*]
    content {
      min_capacity = autoscale_configuration.value.min_capacity
      max_capacity = autoscale_configuration.value.max_capacity
    }
  }

  http2_enabled = var.http2_enabled

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }

  global {
    request_buffering_enabled  = var.global_config.request_buffering_enabled
    response_buffering_enabled = var.global_config.response_buffering_enabled
  }

  ###############################################################
  ### SSL Certificate (.pfx) Configuration (Optional)

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates
    content {
      name                = ssl_certificate.value.name
      data                = ssl_certificate.value.key_vault_secret_id == null ? ssl_certificate.value.data : null
      password            = ssl_certificate.value.key_vault_secret_id == null ? ssl_certificate.value.password : null
      key_vault_secret_id = lookup(ssl_certificate.value, "key_vault_secret_id", null)
    }
  }

  ###############################################################
  ### Backend Address Pool Configuration (Required)

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  ###############################################################
  ### Backend HTTP Settings (Required)

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name     = backend_http_settings.value.name
      port     = backend_http_settings.value.port
      protocol = backend_http_settings.value.protocol

      path       = backend_http_settings.value.path
      probe_name = backend_http_settings.value.probe_name == "" ? null : coalesce(backend_http_settings.value.probe_name, backend_http_settings.value.name)

      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      affinity_cookie_name                = backend_http_settings.value.affinity_cookie_name
      request_timeout                     = backend_http_settings.value.request_timeout
      host_name                           = backend_http_settings.value.host_name
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      trusted_root_certificate_names      = backend_http_settings.value.trusted_root_certificate_names

      dynamic "authentication_certificate" {
        for_each = backend_http_settings.value.authentication_certificate[*]
        content {
          name = authentication_certificate.value
        }
      }

      dynamic "connection_draining" {
        for_each = backend_http_settings.value.connection_draining_timeout_sec[*]
        content {
          enabled           = true
          drain_timeout_sec = connection_draining.value
        }
      }
    }
  }

  ###############################################################
  ### Health Probe (Optional)

  dynamic "probe" {
    for_each = var.health_probes
    content {
      name                                      = probe.value.name
      host                                      = probe.value.host
      interval                                  = probe.value.interval
      protocol                                  = probe.value.port == 443 ? "Https" : "Http"
      path                                      = probe.value.path
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      port                                      = probe.value.port
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      minimum_servers                           = probe.value.minimum_servers
      match {
        body        = probe.value.match.body
        status_code = probe.value.match.status_code
      }
    }
  }

  ###############################################################
  ### Frontend configuration

  ## Public IP
  dynamic "frontend_ip_configuration" {
    for_each = var.public_ip[*]
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = frontend_ip_configuration.value.id
    }
  }

  ## Private IP
  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations_private.enabled ? var.frontend_ip_configurations_private[*] : []
    content {
      name                          = frontend_ip_configuration.value.name
      private_ip_address            = coalesce(frontend_ip_configuration.value.private_ip_address, local.agw_private_ip_address)
      private_ip_address_allocation = "Static"
      subnet_id                     = var.subnet.id
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  ###############################################################
  ### HTTP Listener Configuration (Required)

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet.id
  }

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name = http_listener.value.name
      frontend_ip_configuration_name = coalesce(http_listener.value.frontend_ip_configuration_name,
        var.public_ip != null ? var.public_ip.name : var.frontend_ip_configurations_private.name
      )
      frontend_port_name   = http_listener.value.frontend_port_name
      host_name            = http_listener.value.host_name
      host_names           = http_listener.value.host_names
      protocol             = http_listener.value.protocol
      require_sni          = http_listener.value.require_sni
      ssl_certificate_name = http_listener.value.ssl_certificate_name
      ssl_profile_name     = http_listener.value.ssl_profile_name
      firewall_policy_id   = http_listener.value.firewall_policy_id

      dynamic "custom_error_configuration" {
        for_each = http_listener.value.custom_error_configurations
        iterator = err_conf
        content {
          status_code           = err_conf.value.status_code
          custom_error_page_url = err_conf.value.custom_error_page_url
        }
      }
    }
  }

  ###############################################################
  ### Request routing rules Configuration (Required)

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name      = request_routing_rule.value.name
      rule_type = request_routing_rule.value.rule_type

      http_listener_name          = coalesce(request_routing_rule.value.http_listener_name, request_routing_rule.value.name)
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name
      url_path_map_name           = request_routing_rule.value.url_path_map_name
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_name
      rewrite_rule_set_name       = request_routing_rule.value.rewrite_rule_set_name
      priority                    = coalesce(request_routing_rule.value.priority, request_routing_rule.key + 1)
    }
  }

  ###############################################################
  ### URL Path Mappings (Optional)
  dynamic "url_path_map" {
    for_each = var.url_path_maps
    content {
      name                                = url_path_map.value.name
      default_backend_address_pool_name   = lookup(url_path_map.value, "default_backend_address_pool_name", null)
      default_backend_http_settings_name  = lookup(url_path_map.value, "default_backend_http_settings_name", null)
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name", null)
      default_rewrite_rule_set_name       = lookup(url_path_map.value, "default_rewrite_rule_set_name", null)

      dynamic "path_rule" {
        for_each = try(url_path_map.value.path_rules, [])
        content {
          name                        = path_rule.value.name
          backend_address_pool_name   = path_rule.value.backend_address_pool_name
          backend_http_settings_name  = path_rule.value.backend_http_settings_name
          paths                       = flatten(path_rule.value.paths)
          redirect_configuration_name = lookup(path_rule.value, "redirect_configuration_name", null)
          rewrite_rule_set_name       = lookup(path_rule.value, "rewrite_rule_set_name", null)
          firewall_policy_id          = lookup(path_rule.value, "firewall_policy_id", null)
        }
      }
    }
  }

  ################################################################
  ### Private Link Configuration (Optional)
  dynamic "private_link_configuration" {
    for_each = var.private_link_configurations[*]
    content {
      name = private_link_configuration.value.name

      dynamic "ip_configuration" {
        for_each = private_link_configuration.value.ip_configuration[*]
        content {
          name                          = ip_configuration.value.name
          subnet_id                     = ip_configuration.value.subnet_id
          private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
          private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation", "Dynamic")
          primary                       = lookup(ip_configuration.value, "primary", true)
        }
      }
    }
  }

  ###############################################################
  dynamic "identity" {
    for_each = length(var.user_assigned_identity_ids) > 0 ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.user_assigned_identity_ids
    }
  }

  # Associate with a custom WAF policy to be able to add exception rules
  force_firewall_policy_association = var.sku.name == "WAF_v2" ? true : false
  firewall_policy_id                = var.sku.name == "WAF_v2" ? azurerm_web_application_firewall_policy.this[0].id : null

  // lifecycle {
  //   ignore_changes = [
  //     tags,
  //     # backend_address_pool,
  //     # backend_http_settings,
  //     # http_listener,
  //     # probe,
  //     # request_routing_rule,
  //     # url_path_map,
  //     # frontend_port,
  //     # ssl_certificate,
  //   ]
  // }
}
