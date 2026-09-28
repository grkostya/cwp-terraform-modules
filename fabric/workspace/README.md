<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.18.0 |
| <a name="requirement_fabric"></a> [fabric](#requirement\_fabric) | 1.1.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_fabric"></a> [fabric](#provider\_fabric) | 1.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [fabric_lakehouse.this](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/lakehouse) | resource |
| [fabric_workspace.this](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace) | resource |
| [fabric_workspace_role_assignment.this](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace_role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fabric_capacity_id"></a> [fabric\_capacity\_id](#input\_fabric\_capacity\_id) | The ID of the Fabric Capacity to assign to the Workspace | `string` | n/a | yes |
| <a name="input_fabric_lh_name"></a> [fabric\_lh\_name](#input\_fabric\_lh\_name) | Name of the fabric lakehouse(lh) | `string` | n/a | yes |
| <a name="input_fabric_users"></a> [fabric\_users](#input\_fabric\_users) | Collection of users for the Fabric Workspace. | <pre>list(object({<br/>    principal = object({<br/>      id   = string # User: Object ID, Group: Object ID, ServicePrincipal: Client ID, ServicePrincipalProfile: Client ID<br/>      type = string # User, Group, ServicePrincipal, ServicePrincipalProfile<br/>    })<br/>    role = string # Admin, Member, Contributor<br/>  }))</pre> | `[]` | no |
| <a name="input_fabric_ws_name"></a> [fabric\_ws\_name](#input\_fabric\_ws\_name) | Name of the fabric workspace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Fabric Workspace ID |
| <a name="output_name"></a> [name](#output\_name) | The Fabric Workspace Name |
<!-- END_TF_DOCS -->
