output "subscription_id" {
  value = "8844373f-b359-4443-8560-3a08406cd2eb" ## CR4X-NRGI
}


output "tenant_id" {
  value       = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
  description = "EPAM tenant ID"
}


output "tags" {
  value = local.tags
}


output "psql_backup_policy_name" {
  value = "postgresql-flexible-server-backup-policy"
}


output "allowed_ip_addresses" {
  value       = ["174.128.60.162", "85.223.209.18", "195.56.119.209", "174.128.60.160", "203.170.48.2", "204.153.55.4", "195.56.119.212"]
  description = "EPAM VPN IP addresses"
}
