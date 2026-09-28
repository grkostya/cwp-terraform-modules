resource "azurerm_web_application_firewall_policy" "this" {
  count = var.sku.name == "WAF_v2" ? 1 : 0

  name                = local.waf_custom_policy_name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags


  policy_settings {
    enabled                     = var.waf_custom_policy.policy_settings.enabled                     ## Default: true
    mode                        = var.firewall_mode                                                 ## Default: "Prevention"
    request_body_enforcement    = var.waf_custom_policy.policy_settings.request_body_enforcement    ## Default: true
    file_upload_limit_in_mb     = var.waf_custom_policy.policy_settings.file_upload_limit_in_mb     ## Default: 100
    max_request_body_size_in_kb = var.waf_custom_policy.policy_settings.max_request_body_size_in_kb ## Default: 128
  }


  managed_rules {
    managed_rule_set {
      type    = var.waf_custom_policy.managed_rules.managed_rule_set.type    ## Default: "OWASP"
      version = var.waf_custom_policy.managed_rules.managed_rule_set.version ## Default: "3.2"

      dynamic "rule_group_override" {
        for_each = var.waf_custom_policy.managed_rules.managed_rule_set.rule_group_override
        content {
          rule_group_name = rule_group_override.value.rule_group_name
          dynamic "rule" {
            for_each = rule_group_override.value.rule
            content {
              id      = rule.value.id
              enabled = rule.value.enabled
              action  = rule.value.action
            }
          }
        }
      }
    }

    dynamic "exclusion" {
      for_each = var.waf_custom_policy.managed_rules.exclusion
      content {
        match_variable          = exclusion.value.match_variable
        selector                = exclusion.value.selector
        selector_match_operator = exclusion.value.selector_match_operator
        # dynamic excluded_rule_set {
        #   for_each = var.waf_custom_policy.managed_rules.exclusion.excluded_rule_set
        #   content {
        #   }
        # }
      }
    }
  }

  dynamic "custom_rules" {
    for_each = var.waf_custom_policy.custom_rules
    content {
      name      = custom_rules.value.name
      action    = custom_rules.value.action
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type

      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions
        content {
          dynamic "match_variables" {
            for_each = match_conditions.value.match_variables
            content {
              variable_name = match_variables.value.variable_name
            }
          }
          operator           = match_conditions.value.operator
          negation_condition = match_conditions.value.negation_condition
          match_values       = match_conditions.value.match_values
          transforms         = match_conditions.value.transforms
        }
      }
    }
  }
}
