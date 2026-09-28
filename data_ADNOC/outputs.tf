output "subscription_id" {
  value = local.subscription_id
}


output "management_group_root" {
  value = "MG-ENAI-01"
}


output "management_group" {
  value = local.env == "prd" ? "MG-ENAI-PRD01" : "MG-ENAI-NPD01"
}


output "tenant_id" {
  value       = "7176fd54-26f7-4fc2-ac54-f1cc5086e388"
  description = "ADNOC PrivateSAAS tenant ID"
}


output "tags" {
  value = local.tags
}


output "resource_group_networking" {
  value = try(data.azurerm_resource_group.Networking[0], null)
}


output "virtual_network" {
  value = try(data.azurerm_virtual_network.this[0], null)
}


output "private_dns_zone" {
  value = data.azurerm_private_dns_zone.this
}


output "subnet" {
  value = data.azurerm_subnet.this
}


output "terraform_sp_client_id" {
  value       = "a58f3ed5-1434-4f05-8939-58ce837fe381"
  description = "Service Principal Client ID for terraform deployments (ADNOC EnergyAI Prod)"
}


## Azure Monitor Private Link Scope Name
output "ampls_name" {
  value = "ampls-enai-${local.env}-aen-01"
}


output "devops_ad_group_oid" {
  value       = "6aa8c461-8847-415e-81f7-5e1dbb0d62f3"
  description = "DevOps EntraID group object ID. Group: SG-EAI-AEN-DEV-SRE"
}


output "common_ad_group_oid" {
  value       = "8fc0377c-27df-4cf8-b5ca-88e17c6063cd"
  description = "Common (All users) EntraID group object ID. Group: SG-EAI-AEN-DEV-COM"
}


output "psql_backup_policy_name" {
  value = "postgresql-flexible-server-backup-policy"
}
