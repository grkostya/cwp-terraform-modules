output "subscription_id" {
  value = "9d55879e-111b-4ec0-b077-493d40bf950c" ## CR4X-NRGN
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
