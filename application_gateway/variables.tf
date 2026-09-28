variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the Application Gateway. Changing this forces a new resource to be created.
    location = (Required) The location/region where Application Gateway host is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null

  validation {
    condition     = var.resource_group != null || (var.resource_group_name != null && var.location != null)
    error_message = <<-EOT
      Input is required:
      Provide either the 'resource_group' object or the values for 'resource_group_name' and 'location'
    EOT
  }
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Application Gateway. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where to create the Application Gateway. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "name" {
  type        = string
  description = "(Required) The name of the Application Gateway. Changing this forces a new resource to be created."
}


variable "sku" {
  type = object({
    name = string
    # tier = string
    capacity = optional(number, 2)
  })
  description = <<-EOT
    name     = (Required) The Name of the SKU to use for this Application Gateway.
                Possible values are 'Basic', 'Standard_v2', and 'WAF_v2'
    tier     = (Required) The Tier of the SKU to use for this Application Gateway.
                Possible values are 'Basic', 'Standard_v2', and 'WAF_v2'.
    capacity = (Optional) The Capacity of the SKU to use for this Application Gateway.
                When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU.
                When using a 'Basic' SKU this property must be between 1 and 2.
                This property is optional if 'autoscale_configuration' is set.
    EOT
  default = {
    name = "Standard_v2"
  }
}


variable "autoscale_configuration" {
  type = object({
    min_capacity = number
    max_capacity = optional(number, 5)
  })
  description = <<-EOT
    min_capacity = (Required) The minimum number of instances for the Application Gateway.
    max_capacity = (Optional) The maximum number of instances for the Application Gateway.
  EOT
  default     = null
}


variable "http2_enabled" {
  type        = bool
  description = "(Optional) Is HTTP2 enabled on the application gateway resource? Defaults to 'false'."
  default     = false
}


variable "subnet" {
  type = object({
    name                = string
    id                  = string
    address_prefix      = string
    resource_group_name = string
  })
  description = <<-EOT
    name                = The name of the Subnet.
    id                  = The ID of the Subnet which the Application Gateway should be connected to.
    address_prefix      = The address prefix for the subnet.
    resource_group_name = Specifies the name of the resource group the Virtual Network is located in.
  EOT
}


variable "backend_address_pools" {
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
  description = <<-EOT
    name         = (Required) The Name of the Backend Address Pool.
    fqdns        = (Optional) A list of FQDN's which should be part of the Backend Address Pool.
    ip_addresses = (Optional) A list of IP Addresses which should be part of the Backend Address Pool.
  EOT
  default = [{
    name = "default"
  }]
}


variable "backend_http_settings" {
  type = list(object({
    name     = optional(string, "default")
    port     = optional(number, 443)
    protocol = optional(string, "Https")

    path       = optional(string)
    probe_name = optional(string)

    cookie_based_affinity               = optional(string, "Disabled")
    affinity_cookie_name                = optional(string, "ApplicationGatewayAffinity")
    request_timeout                     = optional(number, 30)
    host_name                           = optional(string)
    pick_host_name_from_backend_address = optional(bool, false)
    trusted_root_certificate_names      = optional(list(string), [])
    authentication_certificate          = optional(string)

    connection_draining_timeout_sec = optional(number)
  }))
  description = <<-EOT
    name     = (Required) The Name of the Backend HTTP Settings.
    port     = (Optional) The Port to use for this Backend HTTP Settings. Defaults to '443'.
    protocol = (Optional) The Protocol to use for this Backend HTTP Settings.
                Possible values are 'Http' and 'Https'. Defaults to 'Https'.

    path       = (Optional) The Path to use for this Backend HTTP Settings.
    probe_name = (Optional) The name of an associated HTTP Probe.

    cookie_based_affinity               = (Required) Is Cookie-Based Affinity enabled?. Possible values are
                                          'Disabled' and 'Enabled'. Defaults to 'Disabled'.
    affinity_cookie_name                = (Optional) The Affinity Cookie Name to use for this Backend HTTP Settings.
                                           Defaults to 'ApplicationGatewayAffinity'.
    request_timeout                     = (Optional) The request timeout in seconds, which must be between
                                           1 and 86400 seconds. Defaults to 30.
    host_name                           = (Optional) Host header to be sent to the backend servers.
                                           Cannot be set if 'pick_host_name_from_backend_address' is set to 'true'.
    pick_host_name_from_backend_address = (Optional) Whether host header should be picked from the host name of the backend server.
                                           Defaults to 'true'.
    trusted_root_certificate_names      = (Optional) A list of Trusted Root Certificate Names to use for
                                           this Backend HTTP Settings.
    authentication_certificate          = (Optional) The Name of the Authentication Certificate to use for
                                           this Backend HTTP Settings.

    connection_draining_timeout_sec = (Required) The number of seconds connection draining is active.
                                       Acceptable values are from 1 second to 3600 seconds.
  EOT
  default     = [{}]
}


variable "health_probes" {
  description = "List of Health probes used to test backend pools health."
  type = list(object({
    name                                      = string
    host                                      = string
    path                                      = optional(string, "/")
    interval                                  = optional(number, 30)
    timeout                                   = optional(number, 30)
    unhealthy_threshold                       = optional(number, 3)
    port                                      = optional(number, 443)
    pick_host_name_from_backend_http_settings = optional(bool, false)
    minimum_servers                           = optional(number, 0)
    match = optional(object({
      body        = optional(string)
      status_code = optional(list(string), ["200-399", ])
    }), { status_code = ["200-399", ] })
  }))
  default = []
}


variable "http_listeners" {
  type = list(object({
    name                           = optional(string, null)
    frontend_ip_configuration_name = optional(string)
    frontend_port_name             = optional(string, "default")
    host_name                      = optional(string)
    host_names                     = optional(list(string))
    protocol                       = optional(string, "Http")
    require_sni                    = optional(bool, false)
    ssl_certificate_name           = optional(string)
    ssl_profile_name               = optional(string)
    firewall_policy_id             = optional(string)

    custom_error_configurations = optional(list(object({
      status_code           = string
      custom_error_page_url = string
    })), [])
  }))
  description = <<-EOT
    name                           = (Required) The Name of the HTTP Listener.
    frontend_ip_configuration_name = (Required) The Name of the Frontend IP Configuration used for
                                      this HTTP Listener.
    frontend_port_name             = (Required) The Name of the Frontend Port use for this HTTP Listener.
    host_name                      = (Optional) The Hostname which should be used for this HTTP Listener.
                                      Setting this value changes Listener Type to 'Multi site'.
    host_names                     = (Optional) A list of Hostname(s) should be used for this HTTP Listener.
                                      It allows special wildcard characters.
                                     NOTE:
                                       The 'host_names' and 'host_name' are mutually exclusive and cannot both be set.
    protocol                       = (Required) The Protocol to use for this HTTP Listener.
                                      Possible values are 'Http' and 'Https'.
    require_sni                    = (Optional) Should Server Name Indication be Required? Defaults to 'false'.
    ssl_certificate_name           = (Optional) The name of the associated SSL Certificate which should be
                                      used for this HTTP Listener.
    ssl_profile_name               = (Optional) The name of the associated SSL Profile which should be
                                      used for this HTTP Listener.
    firewall_policy_id             = (Optional) The ID of the Web Application Firewall Policy which should be
                                      used for this HTTP Listener.

    custom_error_configurations = {
      status_code           = (Required) Status code of the application gateway customer error.
                               Possible values are 'HttpStatus400', 'HttpStatus403', 'HttpStatus404',
                               'HttpStatus405', 'HttpStatus408', 'HttpStatus500', 'HttpStatus502',
                               'HttpStatus503' and 'HttpStatus504'
      custom_error_page_url = (Required) Error page URL of the application gateway customer error.
    }
  EOT
  default = [{
    name = "default"
  }]
}


variable "frontend_ports" {
  type = list(object({
    name = string
    port = number
  }))
  description = <<-EOT
    name = (Required) The Name of the Frontend Port.
    port = (Required) The Port number to use for this Frontend Port.
  EOT
  default = [{
    name = "default"
    port = 80
  }]
  nullable = false
}


variable "frontend_ip_configurations_private" {
  type = object({
    enabled            = optional(bool, true)
    name               = optional(string, "Private-IP")
    private_ip_address = optional(string, null)
  })
  description = <<-EOT
    name               = (Optional) The Name of the Frontend IP Configuration.
    private_ip_address = (Required) The Private IP Address to use for this Frontend IP Configuration.
  EOT
  default     = {}
}


variable "public_ip" {
  type = object({
    name       = string
    id         = string
    ip_address = string
  })
  description = <<-EOT
    name       = The name of the Public IP.
    id         = The ID of this Public IP.
    ip_address = The IP address value that was allocated.
  EOT
  default     = null
}


variable "request_routing_rules" {
  type = list(object({
    name                        = string
    rule_type                   = optional(string, "Basic")
    http_listener_name          = optional(string)
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    url_path_map_name           = optional(string)
    redirect_configuration_name = optional(string)
    rewrite_rule_set_name       = optional(string)
    priority                    = optional(number, 1)
  }))
  description = <<-EOT
    name                        = (Required) The Name of the Request Routing Rule.
    rule_type                   = (Optional) The Rule Type to use for this Request Routing Rule.
                                  Possible values are 'Basic' and 'PathBasedRouting'. Defaults to 'Basic'.
    http_listener_name          = (Optional) The Name of the HTTP Listener to use for this Request Routing Rule.
    backend_address_pool_name   = (Optional) The Name of the Backend Address Pool which should be used for
                                   this Routing Rule. Cannot be set if redirect_configuration_name is set.
    backend_http_settings_name  = (Optional) The Name of the Backend HTTP Settings Collection which should be
                                   used for this Routing Rule. Cannot be set if 'redirect_configuration_name' is set.
    url_path_map_name           = (Optional) The Name of the URL Path Map to use for this Request Routing Rule.
    redirect_configuration_name = (Optional) The Name of the Redirect Configuration which should be used for this
                                   Routing Rule. Cannot be set if either 'backend_address_pool_name' or
                                   'backend_http_settings_name' is set.
    rewrite_rule_set_name       = (Optional) The Name of the Rewrite Rule Set which should be used for this
                                   Routing Rule. Only valid for v2 SKUs.
    priority                    = (Optional) Rule evaluation order can be dictated by specifying an integer value
                                   from 1 to 20000 with 1 being the highest priority and 20000 being the lowest priority.
                                  NOTE:
                                      priority is required when 'sku[0].tier' is set to '*_v2'.

        NOTE:
            'backend_address_pool_name', 'backend_http_settings_name', 'redirect_configuration_name', and
            'rewrite_rule_set_name' are applicable only when 'rule_type' is 'Basic'.
  EOT
  default = [{
    name                       = "default"
    http_listener_name         = "default"
    backend_address_pool_name  = "default"
    backend_http_settings_name = "default"
  }]
}

variable "url_path_maps" {
  description = "List of URL path maps associated to path-based rules."
  type = list(object({
    name                                = string
    default_backend_http_settings_name  = optional(string)
    default_backend_address_pool_name   = optional(string)
    default_redirect_configuration_name = optional(string)
    default_rewrite_rule_set_name       = optional(string)
    path_rules = list(object({
      name                        = string
      backend_address_pool_name   = optional(string)
      backend_http_settings_name  = optional(string)
      paths                       = list(string)
      redirect_configuration_name = optional(string)
      rewrite_rule_set_name       = optional(string)
      firewall_policy_id          = optional(string)
    }))
  }))
  default = []
}


variable "ssl_certificates" {
  description = "List of SSL certificates data for Application gateway"
  type = list(object({
    name                = string
    data                = optional(string)
    password            = optional(string)
    key_vault_secret_id = optional(string)
  }))
  default = []
}


variable "user_assigned_identity_ids" {
  type        = list(string)
  description = "Specifies the List of User Assigned Managed Identity IDs to be assigned to this Application Gateway."
  default     = []
}


variable "global_config" {
  description = "Global config for Application Gateway"
  type = object({
    request_buffering_enabled  = bool
    response_buffering_enabled = bool
  })
  default = {
    request_buffering_enabled  = false
    response_buffering_enabled = false
  }
}


variable "firewall_mode" {
  type        = string
  description = "(Required) The Web Application Firewall Mode. Possible values are 'Detection' and 'Prevention'."
  default     = "Prevention"
}

variable "private_link_configurations" {
  description = "List of private link configurations for the Application Gateway."
  type = list(object({
    name = string
    ip_configuration = list(object({
      name                          = string
      subnet_id                     = string
      private_ip_address            = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic")
      primary                       = optional(bool, true)
    }))
  }))
  default = []
}

## The value depend on the SKU (var.sku.name == "WAF_v2" ? true : false)
# variable "force_firewall_policy_association" {
#   type        = bool
#   description = "(Optional) Should the Application Gateway force the association with the Web Application Firewall Policy? Defaults to 'false'."
#   default     = false
# }
