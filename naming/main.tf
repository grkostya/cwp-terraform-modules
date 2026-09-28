# resource "random_string" "main" {
#   length  = 60
#   special = false
#   upper   = false
#   numeric = var.unique-include-numbers
# }

# resource "random_string" "first_letter" {
#   length  = 1
#   special = false
#   upper   = false
#   numeric = false
# }




locals {
  az = {
    ai_foundry = {
      name        = substr(join("-", compact(["aif", local.name_suffix])), 0, 64)
      name_unique = substr(join("-", compact(["aif", local.name_suffix_unique])), 0, 64)
      dashes      = true
      slug        = "aif"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-z][a-zA-Z0-9-]+$"
    },
    api_management = {
      name        = substr(join("-", compact(["apim", local.name_suffix])), 0, 50)
      name_unique = substr(join("-", compact(["apim", local.name_suffix_unique])), 0, 50)
      dashes      = true
      slug        = "apim"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9-]+$"
    },
    ## Grafana
    dashboard_grafana = {
      name        = substr(join("", compact(["amg", local.name_suffix_safe])), 0, 23)
      name_unique = substr(join("", compact(["amg", local.name_suffix_unique_safe])), 0, 23)
      dashes      = true
      slug        = "amg"
      min_length  = 2
      max_length  = 23
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
    }
    ## Backup Vault
    data_protection_backup_vault = {
      name        = substr(join("-", compact(["bvault", local.name_suffix])), 0, 50)
      name_unique = substr(join("-", compact(["bvault", local.name_suffix_unique])), 0, 50)
      dashes      = true
      slug        = "bvault"
      min_length  = 2
      max_length  = 50
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
    },
    ## Congnitive Services
    document_intelligence = {
      name        = substr(join("-", compact(["di", local.name_suffix])), 0, 64)
      name_unique = substr(join("-", compact(["di", local.name_suffix_unique])), 0, 64)
      dashes      = true
      slug        = "di"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$"
    },
    fabric_capacity = {
      name        = substr(join("", compact(["fc", local.name_suffix_safe])), 0, 63)
      name_unique = substr(join("", compact(["fc", local.name_suffix_unique_safe])), 0, 63)
      dashes      = false
      slug        = "fc"
      min_length  = 3
      max_length  = 63
      scope       = "resourceGroup"
      regex       = "^[a-z0-9]+$"
    },
    fabric_workspace = {
      name        = substr(join("", compact(["fws", local.name_suffix_safe])), 0, 24)
      name_unique = substr(join("", compact(["fws", local.name_suffix_unique_safe])), 0, 24)
      dashes      = true
      slug        = "fws"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
    },
    key_vault = {
      name        = substr(join("", compact(["kv", local.name_suffix_safe])), 0, 24)
      name_unique = substr(join("", compact(["kv", local.name_suffix_unique_safe])), 0, 24)
      dashes      = true
      slug        = "kv"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-zA-Z][a-zA-Z0-9-]+[a-zA-Z0-9]$"
    },
    monitor_private_link_scope = {
      name        = substr(join("-", compact(["ampls", local.name_suffix])), 0, 64)
      name_unique = substr(join("-", compact(["ampls", local.name_suffix_unique])), 0, 64)
      dashes      = true
      slug        = "ampls"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
    },
    ## Prometheus
    monitor_workspace = {
      name        = substr(join("-", compact(["mw", local.name_suffix])), 0, 64)
      name_unique = substr(join("-", compact(["mw", local.name_suffix_unique])), 0, 64)
      dashes      = true
      slug        = "mw"
      min_length  = 3
      max_length  = 44
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$"
    },
    ## Congnitive Services
    openai_account = {
      name        = substr(join("-", compact(["openai", local.name_suffix])), 0, 64)
      name_unique = substr(join("-", compact(["openai", local.name_suffix_unique])), 0, 64)
      dashes      = true
      slug        = "openai"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-]+$"
    },
    purview_account = {
      name        = substr(join("-", compact(["pview", local.name_suffix])), 0, 63)
      name_unique = substr(join("-", compact(["pview", local.name_suffix_unique])), 0, 63)
      dashes      = true
      slug        = "pview"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9-]+$"
    },
    storage_account = {
      name        = substr(join("", compact(["st", local.name_suffix_safe])), 0, 24)
      name_unique = substr(join("", compact(["st", local.name_suffix_unique_safe])), 0, 24)
      dashes      = false
      slug        = "st"
      min_length  = 3
      max_length  = 24
      scope       = "global"
      regex       = "^[a-z0-9]+$"
    },
    user_assigned_identity = {
      name        = substr(join("-", ["id", local.name_suffix]), 0, 128)
      name_unique = substr(join("-", ["id", local.name_suffix_unique]), 0, 128)
      dashes      = true
      slug        = "id"
      min_length  = 3
      max_length  = 128
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9-_]+$"
    },
    lustre = {
      name        = substr(join("-", compact(["lstr", local.name_suffix])), 0, 50)
      name_unique = substr(join("-", compact(["lstr", local.name_suffix_unique])), 0, 50)
      dashes      = true
      slug        = "lstr"
      min_length  = 1
      max_length  = 50
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9-]+$"
    }

  }
  # tflint-ignore: terraform_unused_declarations
  validation = {
    ai_foundry = {
      valid_name        = length(regexall(local.az.ai_foundry.regex, local.az.ai_foundry.name)) > 0 && length(local.az.ai_foundry.name) > local.az.ai_foundry.min_length
      valid_name_unique = length(regexall(local.az.ai_foundry.regex, local.az.ai_foundry.name_unique)) > 0
    },
    api_management = {
      valid_name        = length(regexall(local.az.api_management.regex, local.az.api_management.name)) > 0 && length(local.az.api_management.name) > local.az.api_management.min_length
      valid_name_unique = length(regexall(local.az.api_management.regex, local.az.api_management.name_unique)) > 0
    },
    ## Grafana
    dashboard_grafana = {
      valid_name        = length(regexall(local.az.dashboard_grafana.regex, local.az.dashboard_grafana.name)) > 0 && length(local.az.dashboard_grafana.name) > local.az.dashboard_grafana.min_length
      valid_name_unique = length(regexall(local.az.dashboard_grafana.regex, local.az.dashboard_grafana.name_unique)) > 0
    },
    lustre = {
      valid_name        = length(regexall(local.az.lustre.regex, local.az.lustre.name)) > 0 && length(local.az.lustre.name) > local.az.lustre.min_length
      valid_name_unique = length(regexall(local.az.lustre.regex, local.az.lustre.name_unique)) > 0
    },
    data_protection_backup_vault = {
      valid_name        = length(regexall(local.az.data_protection_backup_vault.regex, local.az.data_protection_backup_vault.name)) > 0 && length(local.az.data_protection_backup_vault.name) > local.az.data_protection_backup_vault.min_length
      valid_name_unique = length(regexall(local.az.data_protection_backup_vault.regex, local.az.data_protection_backup_vault.name_unique)) > 0
    },
    fabric_capacity = {
      valid_name        = length(regexall(local.az.fabric_capacity.regex, local.az.fabric_capacity.name)) > 0 && length(local.az.fabric_capacity.name) > local.az.fabric_capacity.min_length
      valid_name_unique = length(regexall(local.az.fabric_capacity.regex, local.az.fabric_capacity.name_unique)) > 0
    },
    fabric_workspace = {
      valid_name        = length(regexall(local.az.fabric_workspace.regex, local.az.fabric_workspace.name)) > 0 && length(local.az.fabric_workspace.name) > local.az.fabric_workspace.min_length
      valid_name_unique = length(regexall(local.az.fabric_workspace.regex, local.az.fabric_workspace.name_unique)) > 0
    },
    key_vault = {
      valid_name        = length(regexall(local.az.key_vault.regex, local.az.key_vault.name)) > 0 && length(local.az.key_vault.name) > local.az.key_vault.min_length
      valid_name_unique = length(regexall(local.az.key_vault.regex, local.az.key_vault.name_unique)) > 0
    },
    monitor_private_link_scope = {
      valid_name        = length(regexall(local.az.monitor_private_link_scope.regex, local.az.monitor_private_link_scope.name)) > 0 && length(local.az.monitor_private_link_scope.name) > local.az.monitor_private_link_scope.min_length
      valid_name_unique = length(regexall(local.az.monitor_private_link_scope.regex, local.az.monitor_private_link_scope.name_unique)) > 0
    },
    ## Prometheus
    monitor_workspace = {
      valid_name        = length(regexall(local.az.monitor_workspace.regex, local.az.monitor_workspace.name)) > 0 && length(local.az.monitor_workspace.name) > local.az.monitor_workspace.min_length
      valid_name_unique = length(regexall(local.az.monitor_workspace.regex, local.az.monitor_workspace.name_unique)) > 0
    },
    purview_account = {
      valid_name        = length(regexall(local.az.purview_account.regex, local.az.purview_account.name)) > 0 && length(local.az.purview_account.name) > local.az.purview_account.min_length
      valid_name_unique = length(regexall(local.az.purview_account.regex, local.az.purview_account.name_unique)) > 0
    },
    storage_account = {
      valid_name        = length(regexall(local.az.storage_account.regex, local.az.storage_account.name)) > 0 && length(local.az.storage_account.name) > local.az.storage_account.min_length
      valid_name_unique = length(regexall(local.az.storage_account.regex, local.az.storage_account.name_unique)) > 0
    },
    user_assigned_identity = {
      valid_name        = length(regexall(local.az.user_assigned_identity.regex, local.az.user_assigned_identity.name)) > 0 && length(local.az.user_assigned_identity.name) > local.az.user_assigned_identity.min_length
      valid_name_unique = length(regexall(local.az.user_assigned_identity.regex, local.az.user_assigned_identity.name_unique)) > 0
    },

    ## Congnitive Services and AI
    document_intelligence = {
      valid_name        = length(regexall(local.az.document_intelligence.regex, local.az.document_intelligence.name)) > 0 && length(local.az.document_intelligence.name) > local.az.document_intelligence.min_length
      valid_name_unique = length(regexall(local.az.document_intelligence.regex, local.az.document_intelligence.name_unique)) > 0
    },
    openai_account = {
      valid_name        = length(regexall(local.az.openai_account.regex, local.az.openai_account.name)) > 0 && length(local.az.openai_account.name) > local.az.openai_account.min_length
      valid_name_unique = length(regexall(local.az.openai_account.regex, local.az.openai_account.name_unique)) > 0
    }
  }
}
