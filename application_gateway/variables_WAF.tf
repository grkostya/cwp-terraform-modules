variable "waf_custom_policy" {
  type = object({
    policy_settings = optional(object({
      enabled                     = optional(bool, true)
      request_body_enforcement    = optional(bool, true)
      file_upload_limit_in_mb     = optional(number, 100)
      max_request_body_size_in_kb = optional(number, 128)
      # mode = string  ## var.firewall_mode
    }), {})

    managed_rules = optional(object({
      managed_rule_set = optional(object({
        type    = optional(string, "OWASP")
        version = optional(string, "3.2")
        rule_group_override = optional(list(object({
          rule_group_name = string
          rule = list(object({
            id      = string
            enabled = bool
            action  = string
          }))
        })), [])
      }), {})
      exclusion = optional(list(object({
        match_variable          = string
        selector                = string
        selector_match_operator = string
        # excluded_rule_set       = optional(list(object({})), [])
      })), [])
    }), {})

    custom_rules = optional(list(object({
      name      = string
      priority  = number
      rule_type = string

      match_conditions = list(object({
        match_variables = list(object({
          variable_name = string
        }))
        operator           = string
        negation_condition = bool
        match_values       = list(string)
        transforms         = list(string)
      }))

      action = string
    })), [])
  })
  description = <<-EOT
    policy_settings = {
      enabled                     = (Optional) Specifies whether the WAF policy is enabled or not. Default: 'true'
      request_body_enforcement    = (Optional) Specifies whether the request body should be checked or not. Default: 'true'
      file_upload_limit_in_mb     = (Optional) Specifies the file upload limit in MB. Default: 100
      max_request_body_size_in_kb = (Optional) Specifies the maximum request body size in KB. Default: 128
    }
    managed_rules = {
      managed_rule_set = {
        type    = (Optional) The rule set type. Possible values: 'Microsoft_BotManagerRuleSet',
                  'Microsoft_DefaultRuleSet' and 'OWASP'. Defaults to 'OWASP'.
        version = (Required) The rule set version. Possible values: '0.1', '1.0', '1.1', '2.1', '2.2.9', '3.0',
                  '3.1' and '3.2'. Default: '3.2'
        rule_group_override = [{
          rule_group_name =  (Required) The name of the Rule Group. Possible values are 'BadBots',
                             'crs_20_protocol_violations', 'crs_21_protocol_anomalies', 'crs_23_request_limits',
                             'crs_30_http_policy', 'crs_35_bad_robots', 'crs_40_generic_attacks',
                             'crs_41_sql_injection_attacks', 'crs_41_xss_attacks', 'crs_42_tight_security',
                             'crs_45_trojans', 'crs_49_inbound_blocking', 'General', 'GoodBots', 'KnownBadBots',
                             'Known-CVEs', 'REQUEST-911-METHOD-ENFORCEMENT', 'REQUEST-913-SCANNER-DETECTION',
                             'REQUEST-920-PROTOCOL-ENFORCEMENT', 'REQUEST-921-PROTOCOL-ATTACK',
                             'REQUEST-930-APPLICATION-ATTACK-LFI', 'REQUEST-931-APPLICATION-ATTACK-RFI',
                             'REQUEST-932-APPLICATION-ATTACK-RCE', 'REQUEST-933-APPLICATION-ATTACK-PHP',
                             'REQUEST-941-APPLICATION-ATTACK-XSS', 'REQUEST-942-APPLICATION-ATTACK-SQLI',
                             'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION', 'REQUEST-944-APPLICATION-ATTACK-JAVA',
                             'UnknownBots', 'METHOD-ENFORCEMENT', 'PROTOCOL-ENFORCEMENT', 'PROTOCOL-ATTACK', 'LFI',
                             'RFI', 'RCE', 'PHP', 'NODEJS', 'XSS', 'SQLI', 'FIX', 'JAVA', 'MS-ThreatIntel-WebShells',
                             'MS-ThreatIntel-AppSec', 'MS-ThreatIntel-SQLI' and 'MS-ThreatIntel-CVEs'.
          rule = {
            id      = (Required) Specifies the ID of the rule to override.
            enabled = (Optional) Describes if the managed rule is in enabled state or disabled state. Defaults to 'false'.
            action  = (Optional) Describes the override action to be applied when rule matches. Possible values are
                      'Allow', 'AnomalyScoring', 'Block', 'JSChallenge' and 'Log'.
                      'JSChallenge' is only valid for rulesets of type 'Microsoft_BotManagerRuleSet'.
          }
        }]
        esclusion = [{
          match_variable          = (Required) The name of the Match Variable. Possible values:
                                    'RequestArgKeys', 'RequestArgNames', 'RequestArgValues', 'RequestCookieKeys',
                                    'RequestCookieNames', 'RequestCookieValues', 'RequestHeaderKeys',
                                    'RequestHeaderNames', 'RequestHeaderValues'.
          selector                = (Required) Describes field of the matchVariable collection.
          selector_match_operator = (Required) Describes operator to be matched. Possible values:
                                    'Contains', 'EndsWith', 'Equals', 'EqualsAny', 'StartsWith'.
          excluded_rule_set       = (Optional) One or more 'excluded_rule_set' block.
        }]
      }
    }
    custom_rules = [{
      name      =  (Optional) Gets name of the resource that is unique within a policy. This name can be used to access the resource.
      priority  = (Required) Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
      rule_type = (Required) Describes the type of rule. Possible values are 'MatchRule', 'RateLimitRule' and 'Invalid'.

      match_conditions = [{
        match_variables = [{
          variable_name = (Required) The name of the Match Variable. Possible values are
                          'RemoteAddr', 'RequestMethod', 'QueryString', 'PostArgs', 'RequestUri', 'RequestHeaders',
                          'RequestBody' and 'RequestCookies'.
        }]
        operator           = (Required) Describes operator to be matched. Possible values are
                             'Any', 'IPMatch', 'GeoMatch', 'Equal', 'Contains', 'LessThan', 'GreaterThan',
                             'LessThanOrEqual', 'GreaterThanOrEqual', 'BeginsWith', 'EndsWith' and 'Regex'.
        negation_condition = (Required) Specifies whether the condition should be negated or not.
        match_values       = (Optional) A list of match values. This is Required when the operator is not 'Any'.
        transforms         = (Optional) A list of transformations to do before the match is attempted.
                             Possible values are 'HtmlEntityDecode', 'Lowercase', 'RemoveNulls', 'Trim',
                             'Uppercase', 'UrlDecode' and 'UrlEncode'.
      }]

      action =  (Required) Type of action. Possible values are 'Allow', 'Block' and 'Log'.
    }]


    ### EXAMPLE
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

  EOT
  default = {
    policy_settings = {}
    managed_rules = {
      managed_rule_set = {}
    }
    custom_rules = []
  }
}
