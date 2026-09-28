output "id" {
  description = "The Fabric Workspace ID"
  value       = fabric_workspace.this.id
}

output "name" {
  description = "The Fabric Workspace Name"
  value       = fabric_workspace.this.display_name
}
