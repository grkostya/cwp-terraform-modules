<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster_node_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_enabled"></a> [auto\_scaling\_enabled](#input\_auto\_scaling\_enabled) | (Optional) Whether to enable auto-scaler (https://docs.microsoft.com/azure/aks/cluster-autoscaler). | `string` | `true` | no |
| <a name="input_fips_enabled"></a> [fips\_enabled](#input\_fips\_enabled) | (Optional) Should the nodes in this Node Pool have<br/>Federal Information Processing Standard enabled?<br/>Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `bool` | `false` | no |
| <a name="input_gpu_driver"></a> [gpu\_driver](#input\_gpu\_driver) | (Optional) Specifies whether to install the GPU Driver for the nodes.<br/>Possible values are 'Install' and 'None'. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_gpu_instance"></a> [gpu\_instance](#input\_gpu\_instance) | (Optional) Specifies the GPU MIG instance profile for supported GPU VM SKU.<br/>The allowed values are 'MIG1g', 'MIG2g', 'MIG3g', 'MIG4g' and 'MIG7g'.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_host_encryption_enabled"></a> [host\_encryption\_enabled](#input\_host\_encryption\_enabled) | (Optional) Should the nodes in this Node Pool have host encryption enabled? Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `bool` | `true` | no |
| <a name="input_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#input\_kubernetes\_cluster\_id) | (Required) The ID of the Kubernetes Cluster where this Node Pool should exist.<br/>Changing this forces a new resource to be created.<br/>NOTE:<br/>    The type of Default Node Pool for the Kubernetes Cluster must be<br/>    'VirtualMachineScaleSets' to attach multiple node pools. | `string` | n/a | yes |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | (Optional) The maximum number of nodes which should exist within this Node Pool.<br/>Valid values are between 0 and 1000 and must be greater than or equal to 'min\_count'. | `number` | `4` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this property requires specifying 'temporary\_name\_for\_rotation' | `string` | `30` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | (Optional) The minimum number of nodes which should exist within this Node Pool.<br/>Valid values are between 0 and 1000 and must be less than or equal to 'max\_count'. | `number` | `1` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | (Optional) Should this Node Pool be used for System or User resources?<br/>Possible values are 'System' and 'User'. Defaults to 'User'. | `string` | `"User"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Node Pool which should be created within the Kubernetes Cluster.<br/>Changing this forces a new resource to be created.<br/>NOTE:<br/>  A Windows Node Pool cannot have a name longer than 6 characters. | `string` | `"user"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | (Optional) The initial number of nodes which should exist within this Node Pool.<br/>Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive)<br/>for system pools and must be a value in the range 'min\_count' - 'max\_count'. | `number` | `1` | no |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. | `map(string)` | `{}` | no |
| <a name="input_node_public_ip_enabled"></a> [node\_public\_ip\_enabled](#input\_node\_public\_ip\_enabled) | (Optional) Should each node have a Public IP Address?<br/>Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `bool` | `false` | no |
| <a name="input_node_taints"></a> [node\_taints](#input\_node\_taints) | (Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g ['key=value:NoSchedule']). | `list(string)` | `[]` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | (Optional) The Agent Operating System disk size in GB. Changing this property requires specifying temporary\_name\_for\_rotation. | `number` | `128` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System.<br/>Possible values are 'Ephemeral' and 'Managed'. Defaults to 'Managed'.<br/>Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `string` | `"Managed"` | no |
| <a name="input_os_sku"></a> [os\_sku](#input\_os\_sku) | (Optional) Specifies the OS SKU used by the agent pool. Possible values are<br/>'AzureLinux', 'Ubuntu', 'Windows2019' and 'Windows2022'. If not specified, the default is<br/>'Ubuntu' if OSType=Linux<br/>or 'Windows2019' if OSType=Windows.<br/>And the default Windows OSSKU will be changed to 'Windows2022' after 'Windows2019' is deprecated.<br/>Changing this from 'AzureLinux' or 'Ubuntu' to 'AzureLinux' or 'Ubuntu' will not replace the resource,<br/>otherwise it forces a new resource to be created. | `string` | `"Ubuntu"` | no |
| <a name="input_pod_subnet_id"></a> [pod\_subnet\_id](#input\_pod\_subnet\_id) | (Optional) The ID of the Subnet where the pods in the Node Pool should exist. Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `string` | `null` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | (Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool.<br/> Possible values are 'Regular' and 'Spot'. Defaults to 'Regular'.<br/> Changing this forces a new resource to be created. | `string` | `"Regular"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | (Optional) Should the ultra disk be accessible? | `bool` | `false` | no |
| <a name="input_upgrade_settings"></a> [upgrade\_settings](#input\_upgrade\_settings) | drain\_timeout\_in\_minutes      = (Optional) The amount of time in minutes to wait<br/>                                on eviction of pods and graceful termination per node.<br/>                                This eviction wait time honors waiting on<br/>                                pod disruption budgets. If this time is exceeded,<br/>                                the upgrade fails. Unsetting this after configuring it<br/>                                will force a new resource to be created.<br/>max\_surge                     = (Required) The maximum number or percentage of nodes<br/>                                which will be added to the Node Pool size during an upgrade.<br/>max\_unavailable               = (Optional) The maximum number or percentage of nodes which<br/>                                can be unavailable during the upgrade.<br/>node\_soak\_duration\_in\_minutes = (Optional) The amount of time in minutes to wait<br/>                                after draining a node and before reimaging and moving on to next node.<br/><br/>NOTE:<br/>  Exactly one of 'max\_surge' or 'max\_unavailable' must be specified. | <pre>object({<br/>    drain_timeout_in_minutes      = optional(number, 0)<br/>    max_surge                     = optional(string) ##"10%"<br/>    max_unavailable               = optional(string)<br/>    node_soak_duration_in_minutes = optional(number, 0)<br/>  })</pre> | <pre>{<br/>  "max_surge": "10%"<br/>}</pre> | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `string` | `"Standard_D4ds_v5"` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | (Optional) The ID of the Subnet where this Node Pool should exist. Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool<br/>should be located. Changing this property requires specifying 'temporary\_name\_for\_rotation'. | `list(number)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
