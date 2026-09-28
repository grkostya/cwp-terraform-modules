locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))

  agw_private_ip_address = cidrhost(var.subnet.address_prefix, 4)

  waf_custom_policy_name = "waf-policy-${var.name}"
}
