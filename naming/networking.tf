locals {
  networking_name_suffix        = join("-", compact([local.subscription_code, local.env, local.location, var.number]))
  networking_name_suffix_unique = join("-", [local.networking_name_suffix, local.random])

  networking = {
    bastion_host = {
      name        = substr(join("-", compact(["bastion", local.networking_name_suffix])), 0, 80)
      name_unique = substr(join("-", compact(["bastion", local.networking_name_suffix_unique])), 0, 80)
      dashes      = true
      slug        = "bastion"
      min_length  = 1
      max_length  = 80
      scope       = "parent"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
    }
    network_security_group = {
      name        = substr(join("-", compact(["nsg", local.networking_name_suffix])), 0, 80)
      name_unique = substr(join("-", compact(["nsg", local.networking_name_suffix_unique])), 0, 80)
      dashes      = true
      slug        = "nsg"
      min_length  = 1
      max_length  = 80
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
    }
    virtual_network = {
      name        = substr(join("-", compact(["vnet", local.networking_name_suffix])), 0, 64)
      name_unique = substr(join("-", compact(["vnet", local.networking_name_suffix_unique])), 0, 64)
      dashes      = true
      slug        = "vnet"
      min_length  = 2
      max_length  = 64
      scope       = "resourceGroup"
      regex       = "^[a-zA-Z0-9][a-zA-Z0-9-._]+[a-zA-Z0-9_]$"
    }
  }



  ### Validation
  # tflint-ignore: terraform_unused_declarations
  validation_networking = {
    bastion_host = {
      valid_name        = length(regexall(local.networking.bastion_host.regex, local.networking.bastion_host.name)) > 0 && length(local.networking.bastion_host.name) > local.networking.bastion_host.min_length
      valid_name_unique = length(regexall(local.networking.bastion_host.regex, local.networking.bastion_host.name_unique)) > 0
    }
    network_security_group = {
      valid_name        = length(regexall(local.networking.network_security_group.regex, local.networking.network_security_group.name)) > 0 && length(local.networking.network_security_group.name) > local.networking.network_security_group.min_length
      valid_name_unique = length(regexall(local.networking.network_security_group.regex, local.networking.network_security_group.name_unique)) > 0
    }
    virtual_network = {
      valid_name        = length(regexall(local.networking.virtual_network.regex, local.networking.virtual_network.name)) > 0 && length(local.networking.virtual_network.name) > local.networking.virtual_network.min_length
      valid_name_unique = length(regexall(local.networking.virtual_network.regex, local.networking.virtual_network.name_unique)) > 0
    }
  }
}
