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
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) Specifies the name of the local administrator account. | `string` | `"azureuser"` | no |
| <a name="input_bypass_platform_safety_checks_on_user_schedule_enabled"></a> [bypass\_platform\_safety\_checks\_on\_user\_schedule\_enabled](#input\_bypass\_platform\_safety\_checks\_on\_user\_schedule\_enabled) | (Optional) Specifies whether to skip platform scheduled patching when a user schedule<br/>is associated with the VM. Defaults to 'false'.<br/><br/>Note:<br/>    'bypass\_platform\_safety\_checks\_on\_user\_schedule\_enabled' can only be set to<br/>    'true' when 'patch\_mode' is set to 'AutomaticByPlatform'. | `bool` | `false` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | (Optional) Specifies custom data to supply to the machine.<br/>On Linux-based systems, this can be used as a cloud-init script.<br/>On other systems, this will be copied as a file on disk.<br/>Internally, Terraform will base64 encode this value before sending it to the API.<br/>The maximum length of the binary array is 65535 bytes.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | (Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with 'secure\_vm\_disk\_encryption\_set\_id'. | `string` | `null` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | (Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted<br/>by enabling Encryption at Host?<br/>NOTE:<br/>'encryption\_at\_host\_enabled' cannot be set to 'true' when 'security\_encryption\_type' is set to 'DiskWithVMGuestState'. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | type         = (Required) Specifies the type of Managed Service Identity that<br/>                should be configured on this Linux Virtual Machine.<br/>                Possible values are 'SystemAssigned', 'UserAssigned',<br/>                'SystemAssigned, UserAssigned' (to enable both)<br/>identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned<br/>                to this Linux Virtual Machine. | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": null,<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the virtual machine is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | (Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `null` | no |
| <a name="input_os_image"></a> [os\_image](#input\_os\_image) | publisher = (Required) Specifies the publisher of the image used to create the virtual machines.<br/>offer     = (Required) Specifies the offer of the image used to create the virtual machines.<br/>sku       = (Required) Specifies the SKU of the image used to create the virtual machines.<br/>version   = (Required) Specifies the version of the image used to create the virtual machines.<br/><br/>Changing this forces a new resource to be created. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | <pre>{<br/>  "offer": "ubuntu-24_04-lts",<br/>  "publisher": "Canonical",<br/>  "sku": "server",<br/>  "version": "latest"<br/>}</pre> | no |
| <a name="input_patch_assessment_mode"></a> [patch\_assessment\_mode](#input\_patch\_assessment\_mode) | (Optional) Specifies the mode of VM Guest Patching for the Virtual Machine.<br/>Possible values are 'AutomaticByPlatform' or 'ImageDefault'.<br/>Defaults to 'AutomaticByPlatform'.<br/>NOTE:<br/>If the patch\_assessment\_mode is set to 'AutomaticByPlatform' then<br/>the 'provision\_vm\_agent' field must be set to 'true'. | `string` | `"AutomaticByPlatform"` | no |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine.<br/>Possible values are 'AutomaticByPlatform' and 'ImageDefault'.<br/>Defaults to 'AutomaticByPlatform'. For more information on patch modes please see the product documentation.<br/>NOTE:<br/>If 'patch\_mode' is set to 'AutomaticByPlatform' then 'provision\_vm\_agent' must also be set to 'true'. | `string` | `"AutomaticByPlatform"` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | (Optional) Reference to a Public IP Address to associate with this NIC | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the virtual machine is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | (Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | (Required) The Public SSH Key.<br/>Example:<br/>  ssh\_keys = file("~/.ssh/id\_rsa.pub") | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet where this Network Interface should be located in. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Required) Specifies the name of the virtual machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) Specifies the size of the Virtual Machine. | `string` | `"Standard_B2ats_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_computer_name"></a> [computer\_name](#output\_computer\_name) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_identity"></a> [identity](#output\_identity) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_os_disk_name"></a> [os\_disk\_name](#output\_os\_disk\_name) | n/a |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | n/a |
<!-- END_TF_DOCS -->
