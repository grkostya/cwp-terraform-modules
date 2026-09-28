<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.95.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.27.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.95.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.27.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [kubernetes_service_account_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_RBAC_roles"></a> [RBAC\_roles](#input\_RBAC\_roles) | scope     = (Required) The scope at which the Role Assignment applies to, such as<br/>            '/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333',<br/>            '/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup',<br/>            or '/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM',<br/>            or '/providers/Microsoft.Management/managementGroups/myMG'.<br/>            Changing this forces a new resource to be created.<br/>role\_name = (Optional) The name of a built-in Role. Changing this forces a new resource to be created. | <pre>map(object({<br/>    scope     = string<br/>    role_name = string<br/>  }))</pre> | `{}` | no |
| <a name="input_create_k8s_service_account"></a> [create\_k8s\_service\_account](#input\_create\_k8s\_service\_account) | (Optional) Whether a Kubernetes service account should be created for the workload identity | `bool` | `false` | no |
| <a name="input_federated_credential"></a> [federated\_credential](#input\_federated\_credential) | oidc\_issuer\_url = (Required) Specifies the issuer of this Federated Identity Credential.<br/>audience        = (Required) Specifies the audience for this Federated Identity Credential. | <pre>object({<br/>    oidc_issuer_url = string<br/>    audience        = optional(list(string), ["api://AzureADTokenExchange"])<br/>  })</pre> | `null` | no |
| <a name="input_federation_name"></a> [federation\_name](#input\_federation\_name) | (Optional) The name of the Federated Identity Credential.<br/>If not specified, the name will be derived from the 'k8s\_service\_account\_name' name. | `string` | `null` | no |
| <a name="input_identity_name"></a> [identity\_name](#input\_identity\_name) | (Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created. | `string` | n/a | yes |
| <a name="input_k8s_annotations"></a> [k8s\_annotations](#input\_k8s\_annotations) | (Optional) An unstructured key value map stored with the service account that may be used to store arbitrary metadata. | `map(string)` | `{}` | no |
| <a name="input_k8s_labels"></a> [k8s\_labels](#input\_k8s\_labels) | (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the service account. May match selectors of replication controllers and services. | `map(string)` | `{}` | no |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | (Optional) Namespace defines the space within which name of the service account must be unique. | `string` | `"default"` | no |
| <a name="input_k8s_service_account_name"></a> [k8s\_service\_account\_name](#input\_k8s\_service\_account\_name) | (Optional) Name of the service account, must be unique. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the User Assigned Identity should exist.<br/>Changing this forces a new User Assigned Identity to be created. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.<br/>location = (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist.<br/>Changing this forces a new User Assigned Identity to be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | User-Assigned Managed Identity Client ID |
| <a name="output_id"></a> [id](#output\_id) | User-Assigned Managed Identity resource ID |
| <a name="output_name"></a> [name](#output\_name) | User-Assigned Managed Identity name |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | User-Assigned Managed Identity Principal ID (Object ID) |
<!-- END_TF_DOCS -->
