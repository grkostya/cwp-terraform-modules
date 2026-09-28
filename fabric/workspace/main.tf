# Create a Fabric Workspace.
resource "fabric_workspace" "this" {
  display_name = var.fabric_ws_name
  description  = "Created by Terraform"
  capacity_id  = var.fabric_capacity_id # (String) The ID of the Fabric Capacity to assign to the Workspace.
  identity = {
    type = "SystemAssigned"
  }
}

# Assign a user to the Fabric workspace
resource "fabric_workspace_role_assignment" "this" {
  for_each     = { for idx, user in var.fabric_users : tostring(idx) => user }
  workspace_id = fabric_workspace.this.id
  principal    = each.value.principal
  role         = each.value.role
}

# Create Fabric lakehouse resource
resource "fabric_lakehouse" "this" {
  count        = trimspace(var.fabric_lh_name) != "" ? 1 : 0
  display_name = var.fabric_lh_name
  description  = "Created by Terraform"
  workspace_id = fabric_workspace.this.id
  depends_on   = [fabric_workspace.this]
}

# Create Fabric Workspace Git resource - 'Workspace Git integration' is not available without explicitly opt-in to the preview mode on the provider level configuration.
# resource "fabric_workspace_git" "this" {
#   count                   = trimspace(var.ado_repository_name) != "" ? 1 : 0
#   workspace_id            = fabric_workspace.this.id
#   initialization_strategy = "PreferWorkspace"
#   git_provider_details = {
#     git_provider_type = "AzureDevOps"
#     organization_name = var.ado_organization_name
#     project_name      = var.ado_project_name
#     repository_name   = var.ado_repository_name
#     branch_name       = var.ado_branch_name
#     directory_name    = var.ado_directory_name
#   }
#   depends_on = [fabric_workspace.this]
# }
