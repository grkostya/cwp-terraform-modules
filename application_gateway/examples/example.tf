module "Application_Gateway" {
  source = "../../../modules/application_gateway"

  name           = module.naming.azure.application_gateway.name
  resource_group = azurerm_resource_group.this

  subnet = azurerm_subnet.application_gateway

  ## SKU
  # sku = {
  #   name = "WAF_v2"  ## Default: "Standard_v2"
  #   # capacity = 1   ## Default: 2
  # }

  # autoscale_configuration = {
  #   min_capacity = 2
  #   # max_capacity = 10
  # }

  ## Private IP address (will be created by default)
  #   frontend_ip_configurations_private = {
  #     # enabled            = false  ## Default: true
  #     # private_ip_address = ""     ## Default: cidrhost(var.subnet.address_prefix, 4)
  #   }

  ## Public IP address
  #   # public_ip = {
  #   #     name = "appgw-public-ip"
  #   #     id   = azurerm_public_ip.this.id
  #   # }
  #   ## Or
  #   # public_ip = data.azurerm_public_ip.appgw





  ## WAF policy (Will be created if sku.name == "WAF_v2")
  # firwall_mode = "Detection"  ## Default: "Prevention"
  # waf_custom_policy = {
  #   # policy_settings = {
  #   #   # enabled                     = false        ## Default: true
  #   #   # request_body_check          = false        ## Default: true
  #   #   file_upload_limit_in_mb     = 50 ## Default: 100
  #   #   max_request_body_size_in_kb = 64 ## Default: 128}
  #   # }

  #   # managed_rules = {
  #   #   managed_rule_set = {
  #   #     # type    = "OWASP"  ## Default: "OWASP"
  #   #     # version = "3.2"    ## Default: "3.2"
  #   #     # rule_group_override = [{ ## Optional
  #   #     #   rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
  #   #     #   rule = {
  #   #     #     id      = "920300"
  #   #     #     enabled = true
  #   #     #     action  = "Log"
  #   #     #   }
  #   #     # }]
  #   #   }
  #   # }

  #   # custom_rules = [{
  #   #   name      = "Kyecloak"
  #   #   priority  = 2
  #   #   rule_type = "MatchRule"

  #   #   match_conditions = [{
  #   #     match_variables = [{
  #   #       variable_name = "RequestUri"
  #   #     }]
  #   #     operator           = "Contains"
  #   #     negation_condition = false
  #   #     match_values       = ["/realms/bn", "api/auth/callback", "admin/master/console/#/bn"]
  #   #     transforms         = ["Lowercase"]
  #   #   }]

  #   #   action = "Allow"
  #   # }]
  # }


  ## NSG rules
  # create_NSG_rules = true  ## Default: false
  # NSG = data.azurerm_network_security_group.appgw
}
