<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.95.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >=2.47.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.95.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_active_directory_administrator.groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_active_directory_administrator) | resource |
| [azurerm_postgresql_flexible_server_active_directory_administrator.service_principals](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_active_directory_administrator) | resource |
| [azurerm_postgresql_flexible_server_active_directory_administrator.users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_active_directory_administrator) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |
| [azurerm_private_dns_zone.PostgreSQL_Flexible](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.PostgreSQL_Flexible](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_subnet.PostgreSQL_Flexible](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [azuread_group.db_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.db_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.db_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | (Optional) The Administrator login for the PostgreSQL Flexible Server. Required when 'create\_mode' is 'Default' and 'authentication.password\_auth\_enabled' is 'true'. | `string` | `null` | no |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password) | (Optional) The Password associated with the 'administrator\_login' for the PostgreSQL Flexible Server. Required when 'create\_mode' is 'Default' and 'authentication.password\_auth\_enabled' is 'true'. | `string` | `null` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | (Optional) Is the storage auto grow enabled? Defaults to 'false'. | `bool` | `false` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | (Optional) The backup retention days for the PostgreSQL Flexible Server.<br/>Possible values are between 7 and 35 days. | `number` | `7` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | block supports the following:<br/><br/>  key\_vault\_key\_id                     = (Required) The ID of the Key Vault Key.<br/>  primary\_user\_assigned\_identity\_id    = (Optional) Specifies the primary user managed identity id<br/>                                         for a Customer Managed Key. Should be added with identity\_ids.<br/>  geo\_backup\_key\_vault\_key\_id          = (Optional) The ID of the geo backup Key Vault Key.<br/>                                         It can't cross region and need Customer Managed Key in<br/>                                         same region as geo backup.<br/>  geo\_backup\_user\_assigned\_identity\_id = (Optional) The geo backup user managed identity id<br/>                                         for a Customer Managed Key. Should be added with 'identity\_ids'.<br/>                                         It can't cross region and need identity in same region as geo backup.<br/>  NOTE:<br/>  'primary\_user\_assigned\_identity\_id' or 'geo\_backup\_user\_assigned\_identity\_id' is required when 'type'<br/>  is set to 'UserAssigned'. | <pre>object({<br/>    key_vault_key_id                     = string<br/>    primary_user_assigned_identity_id    = optional(string)<br/>    geo_backup_key_vault_key_id          = optional(string)<br/>    geo_backup_user_assigned_identity_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_default_database_administrator_object_ids"></a> [default\_database\_administrator\_object\_ids](#input\_default\_database\_administrator\_object\_ids) | The map of sets of object IDs of users, service principals or security groups<br/>in the Azure Active Directory tenant set as the Flexible Server Admin.<br/>Changing this forces a new resource to be created."<br/>EXAMPLE:<br/>default\_database\_administrator\_object\_ids = {<br/>  User = ["00000000-0000-0000-0000-000000000000",]<br/>  Group = []<br/>  ServicePrincipal = []<br/>} | `map(set(string))` | <pre>{<br/>  "Group": [],<br/>  "ServicePrincipal": [],<br/>  "User": []<br/>}</pre> | no |
| <a name="input_delegated_subnet"></a> [delegated\_subnet](#input\_delegated\_subnet) | (Optional) The values to create the virtual network delegated subnet for the private PostgreSQL Flexible Server. | <pre>object({<br/>    name                 = optional(string, "postgresql")<br/>    virtual_network_name = string<br/>    resource_group_name  = string<br/>    address_prefixes     = optional(list(string), ["10.0.2.0/24"])<br/>  })</pre> | `null` | no |
| <a name="input_existing_delegated_subnet_id"></a> [existing\_delegated\_subnet\_id](#input\_existing\_delegated\_subnet\_id) | (Optional) The ID of the virtual network subnet to create the PostgreSQL Flexible Server.<br/>The provided subnet should not have any other resource deployed in it and this subnet will be delegated<br/>to the PostgreSQL Flexible Server, if not already delegated. Changing this forces<br/>a new PostgreSQL Flexible Server to be created | `string` | `null` | no |
| <a name="input_existing_private_dns_zone_id"></a> [existing\_private\_dns\_zone\_id](#input\_existing\_private\_dns\_zone\_id) | (Optional) The ID of the Private DNS Zone to register a private endpoint's IP. | `string` | `null` | no |
| <a name="input_firewall_rule_CIDRs"></a> [firewall\_rule\_CIDRs](#input\_firewall\_rule\_CIDRs) | Provide the list of allowed internet address ranges by using CIDR notation in the form "0.0.0.0/24"<br/>or as individual IP addresses like  "0.0.0.0"<br/>EXAMPLE:<br/>firewall\_rule\_CIDRs = ["1.1.1.0/24", "0.0.0.0", ] | `list(string)` | `[]` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | EXAMPLE:<br/>name = {  (Required) The name which should be used for this PostgreSQL Flexible Server Firewall Rule. Changing this forces a new PostgreSQL Flexible Server Firewall Rule to be created.<br/>  start\_ip\_address = "0.0.0.0"<br/>  end\_ip\_address   = "0.0.0.0"<br/>} | `map(map(string))` | `{}` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | type         = (Required) Specifies the type of Managed Service Identity that should be configured on<br/>               this PostgreSQL Flexible Server. The only possible value is 'UserAssigned'<br/>identity\_ids = (Required) A list of User Assigned Managed Identity IDs to be assigned to<br/>               this PostgreSQL Flexible Server. Required if used together with 'customer\_managed\_key' block. | <pre>object({<br/>    type         = string<br/>    identity_ids = set(string)<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the PostgreSQL Flexible Server should exist.<br/>Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name which should be used for this PostgreSQL Flexible Server.<br/>Changing this forces a new PostgreSQL Flexible Server to be created.<br/>NOTE:<br/>This must be unique across the entire Azure service, not just within the resource group. | `string` | n/a | yes |
| <a name="input_password_auth_enabled"></a> [password\_auth\_enabled](#input\_password\_auth\_enabled) | (Optional) Whether or not password authentication is allowed to access the PostgreSQL Flexible Server. | `bool` | `false` | no |
| <a name="input_pg_version"></a> [pg\_version](#input\_pg\_version) | (Optional) The version of PostgreSQL Flexible Server to use.<br/>Possible values are 11, 12, 13, 14, 15 and 16.<br/>Required when 'create\_mode' is 'Default'.<br/>NOTE:<br/>When 'create\_mode' is 'Update', upgrading version wouldn't force a new resource to be created. | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the PostgreSQL Flexible Server. Changing this forces a new resource to be created.<br/>location = (Required) The Azure Region where the PostgreSQL Flexible Server is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the PostgreSQL Flexible Server should exist.<br/>Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The SKU Name for the PostgreSQL Flexible Server.<br/>The name of the SKU, follows the 'tier' + 'name' pattern (e.g. B\_Standard\_B1ms, GP\_Standard\_D2s\_v3, MO\_Standard\_E4s\_v3) | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | mb   = (Optional) The max storage allowed for the PostgreSQL Flexible Server.<br/>                  Possible values are '32768', '65536', '131072', '262144', '524288', '1048576', '2097152',<br/>                  '4193280', '4194304', '8388608', '16777216' and '33553408'.<br/>                  Note:<br/>                  If the 'storage\_mb' field is undefined on the initial deployment of the PostgreSQL<br/>                  Flexible Server resource it will default to '32768'.<br/>                  If the 'storage\_mb' field has been defined and then removed, the 'storage\_mb'<br/>                  field will retain the previously defined value.<br/>                  The 'storage\_mb' can only be scaled up, for example,<br/>                  you can scale the storage\_mb from '32768' to '65536', but not from '65536' to '32768'.<br/>tier = (Optional) The name of storage performance tier for IOPS of the PostgreSQL Flexible Server.<br/>                  Possible values are 'P4', 'P6', 'P10', 'P15', 'P20', 'P30', 'P40', 'P50', 'P60', 'P70' or 'P80'.<br/>                  Default value is dependant on the 'storage\_mb' value.<br/>                  Please see the 'storage\_tier' defaults based on 'storage\_mb' table in docs.<br/>                  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server<br/>                  Note:<br/>                  The storage\_tier can be scaled once every 12 hours, this restriction is in place to ensure<br/>                  stability and performance after any changes to your PostgreSQL Flexible Server's configuration. | <pre>object({<br/>    mb   = number<br/>    tier = string<br/>  })</pre> | <pre>{<br/>  "mb": 32768,<br/>  "tier": "P4"<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_delegated_subnet_id"></a> [delegated\_subnet\_id](#output\_delegated\_subnet\_id) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_private_dns_zone"></a> [private\_dns\_zone](#output\_private\_dns\_zone) | n/a |
<!-- END_TF_DOCS -->
