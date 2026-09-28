<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.95.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.95.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Required) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | `"azureuser"` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | (Optional) Specifies the Hostname which should be used for this Virtual Machine.<br/>If unspecified this defaults to the value for the 'name' field.<br/>If the value of the 'name' field is not a valid 'computer\_name', then you must specify 'computer\_name'.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | (Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | (Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with 'secure\_vm\_disk\_encryption\_set\_id'. | `string` | `null` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | (Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted<br/>by enabling Encryption at Host?<br/>NOTE:<br/>'encryption\_at\_host\_enabled' cannot be set to 'true' when 'security\_encryption\_type' is set to 'DiskWithVMGuestState'. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the virtual machine is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | (Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `null` | no |
| <a name="input_os_image"></a> [os\_image](#input\_os\_image) | publisher = (Required) Specifies the publisher of the image used to create the virtual machines.<br/>offer     = (Required) Specifies the offer of the image used to create the virtual machines.<br/>sku       = (Required) Specifies the SKU of the image used to create the virtual machines.<br/>version   = (Required) Specifies the version of the image used to create the virtual machines.<br/><br/>Changing this forces a new resource to be created. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | <pre>{<br/>  "offer": "WindowsServer",<br/>  "publisher": "MicrosoftWindowsServer",<br/>  "sku": "2025-datacenter-azure-edition",<br/>  "version": "latest"<br/>}</pre> | no |
| <a name="input_patch_assessment_mode"></a> [patch\_assessment\_mode](#input\_patch\_assessment\_mode) | (Optional) Specifies the mode of VM Guest Patching for the Virtual Machine.<br/>Possible values are 'AutomaticByPlatform' or 'ImageDefault'.<br/>Defaults to 'ImageDefault'.<br/>NOTE:<br/>If the patch\_assessment\_mode is set to 'AutomaticByPlatform' then<br/>the 'provision\_vm\_agent' field must be set to 'true'. | `string` | `"ImageDefault"` | no |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | (Optional) Specifies the mode of in-guest patching to this Windows Virtual Machine.<br/>Possible values are 'Manual', 'AutomaticByOS' and 'AutomaticByPlatform'. Defaults to 'AutomaticByOS'.<br/>For more information on patch modes please see the product documentation.<br/>NOTE:<br/>If 'patch\_mode' is set to 'AutomaticByPlatform' then 'provision\_vm\_agent' must also be set to 'true'.<br/>If the Virtual Machine is using a hotpatching enabled image the 'patch\_mode' must always be set to 'AutomaticByPlatform'. | `string` | `"AutomaticByOS"` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | (Optional) Reference to a Public IP Address to associate with NIC | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the virtual machine is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | (Optional) Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet where this Network Interface should be located in. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Required) Specifies the name of the virtual machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) The SKU which should be used for this Virtual Machine | `string` | `"Standard_B2ats_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | n/a |
| <a name="output_vm_identity"></a> [vm\_identity](#output\_vm\_identity) | n/a |
<!-- END_TF_DOCS -->
