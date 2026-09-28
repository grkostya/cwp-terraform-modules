# Terraform Module for Azure Storage Account

This Terraform module creates a storage account in Azure.

<br><br>

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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.95.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_static_website.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_static_website) | resource |
| [azurerm_storage_container.Containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | (Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2 | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | (Required) Defines the type of replication to use for this storage account.<br/>Valid options are 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS' and 'RAGZRS'.<br/>Changing this forces a new resource to be created when types 'LRS', 'GRS' and 'RAGRS' are changed to<br/>'ZRS', 'GZRS' or 'RAGZRS' and vice versa. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | (Required) Defines the Tier to use for this storage account. Valid options are 'Standard' and 'Premium'.<br/>For 'BlockBlobStorage' and 'FileStorage' accounts only 'Premium' is valid.<br/>Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | (Optional) Allow or disallow nested items within this Account to opt into being public. | `bool` | `false` | no |
| <a name="input_allowed_copy_scope"></a> [allowed\_copy\_scope](#input\_allowed\_copy\_scope) | (Optional) Restrict copy to and from Storage Accounts within an AAD tenant or<br/>with Private Links to the same VNet. Possible values are 'AAD' and 'PrivateLink'. | `string` | `"AAD"` | no |
| <a name="input_blob_container_delete_retention_policy_days"></a> [blob\_container\_delete\_retention\_policy\_days](#input\_blob\_container\_delete\_retention\_policy\_days) | (Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. | `number` | `7` | no |
| <a name="input_blob_cors_rule"></a> [blob\_cors\_rule](#input\_blob\_cors\_rule) | (Optional) A list of CORS rules. Each rule allows origins and methods.<br/>Each rule must have the following fields:<br/>  allowed\_headers     = (Required) List of headers allowed to be part of the CORS request.<br/>  allowed\_methods     = (Required) A list of HTTP methods that are allowed to be executed by the origin.<br/>                         Valid options are 'DELETE', 'GET', 'HEAD', 'MERGE', 'POST', 'OPTIONS', 'PUT' or 'PATCH'.<br/>  allowed\_origins     = (Required) A list of origin domains that will be allowed by CORS.<br/>  exposed\_headers     = (Required) A list of response headers that are exposed to CORS clients.<br/>  max\_age\_in\_seconds  = (Required) The number of seconds that the client/browser should cache a preflight request. | <pre>list(object({<br/>    allowed_headers    = list(string)<br/>    allowed_methods    = list(string)<br/>    allowed_origins    = list(string)<br/>    exposed_headers    = list(string)<br/>    max_age_in_seconds = number<br/>  }))</pre> | `[]` | no |
| <a name="input_blob_delete_retention_policy_days"></a> [blob\_delete\_retention\_policy\_days](#input\_blob\_delete\_retention\_policy\_days) | (Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. | `number` | `7` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | (Optional) Should cross Tenant replication be enabled? | `bool` | `false` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | block supports the following:<br/><br/>  key\_vault\_key\_id          = (Optional) The ID of the Key Vault Key,<br/>                              supplying a version-less key ID will enable auto-rotation of this key.<br/>  managed\_hsm\_key\_id        = (Optional) The ID of the managed HSM Key.<br/>  user\_assigned\_identity\_id = (Required) The ID of a user assigned identity.<br/>  NOTE:<br/>  'customer\_managed\_key' can only be set when the 'account\_kind' is set to 'StorageV2'<br/>  or 'account\_tier' set to 'Premium', and the 'identity' type is 'UserAssigned'.<br/>  Exactly one of 'key\_vault\_key\_id' and 'managed\_hsm\_key\_id' may be specified. | <pre>object({<br/>    key_vault_key_id          = optional(string)<br/>    managed_hsm_key_id        = optional(string)<br/>    user_assigned_identity_id = string<br/>  })</pre> | `null` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | (Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. | `bool` | `true` | no |
| <a name="input_enable_static_website"></a> [enable\_static\_website](#input\_enable\_static\_website) | Enable static website hosting | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | type         = (Required) Specifies the type of Managed Service Identity<br/>               that should be configured on this Storage Account.<br/>               Possible values are 'SystemAssigned', 'UserAssigned',<br/>               'SystemAssigned, UserAssigned' (to enable both).<br/>identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs<br/>                to be assigned to this Storage Account.<br/>                This is required when type is set to 'UserAssigned' or 'SystemAssigned, UserAssigned'.<br/>NOTE:<br/>The assigned prin'cipal\_id and 'tenant\_id' can be retrieved after the identity 'type'<br/>has been set to 'SystemAssigned' and Storage Account has been created. | <pre>object({<br/>    type         = string<br/>    identity_ids = set(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | (Optional) Is infrastructure encryption enabled?<br/>Changing this forces a new resource to be created. Defaults to 'true'.<br/>NOTE:<br/>This can only be true when 'account\_kind' is 'StorageV2'<br/>or when 'account\_tier' is 'Premium' and 'account\_kind' is one of 'BlockBlobStorage' or 'FileStorage'. | `bool` | `true` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | (Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.<br/>Changing this forces a new resource to be created.<br/>NOTE:<br/>This can only be true when 'account\_tier' is 'Standard'<br/>or when 'account\_tier' is 'Premium' and 'account\_kind' is 'BlockBlobStorage' | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the storage account.<br/>Only lowercase Alphanumeric characters allowed.<br/>Changing this forces a new resource to be created.<br/>This must be unique across the entire Azure service, not just within the resource group. | `string` | n/a | yes |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | default\_action             = (Required) Specifies the default action of allow or deny when no other rules match.<br/>                              Valid options are 'Deny' or 'Allow'.<br/>ip\_rules                   = (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed.<br/>                              Private IP address ranges are not allowed.<br/>                              NOTE 1:<br/>                              Small address ranges using "/31" or "/32" prefix sizes are not supported.<br/>                              These ranges should be configured using individual IP address rules without prefix specified.<br/>                              NOTE 2:<br/>                              IP network rules have no effect on requests originating from the same Azure region<br/>                              as the storage account. Use Virtual network rules to allow same-region requests.<br/>                              Services deployed in the same region as the storage account use private Azure IP addresses<br/>                              for communication. Thus, you cannot restrict access to specific Azure services based on their<br/>                              public outbound IP address range.<br/>                              NOTE 3:<br/>                              User has to explicitly set ip\_rules to empty slice ([]) to remove it.<br/>virtual\_network\_subnet\_ids = (Optional) A list of virtual network subnet ids to secure the storage account.<br/>                              NOTE:<br/>                              User has to explicitly set virtual\_network\_subnet\_ids to empty slice ([]) to remove it.<br/>bypass                     = (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices.<br/>                              Valid options are any combination of 'Logging', 'Metrics', 'AzureServices', or 'None'.<br/>                              NOTE:<br/>                              User has to explicitly set bypass to empty slice ([]) to remove it. | <pre>object({<br/>    default_action             = optional(string, "Deny")<br/>    ip_rules                   = optional(set(string))<br/>    virtual_network_subnet_ids = optional(set(string))<br/>    bypass                     = optional(set(string), ["None"]) ## ["AzureServices", "Metrics", ]<br/>  })</pre> | `{}` | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created"<br/>NOTE:<br/>This can only be true when account\_tier is 'Standard' and account\_kind is 'StorageV2',<br/>or account\_tier is 'Premium' and account\_kind is 'BlockBlobStorage'.<br/>Additionally, the 'is\_hns\_enabled' is 'true' and 'account\_replication\_type' must be 'LRS' or 'RAGRS'. | `bool` | `false` | no |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | subnet\_id                  = The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created.<br/>virtual\_networks           = A map of Virtual Network data references. Required to get Virtual Network IDs that should be linked to the DNS Zone. Changing this forces a new resource to be created.<br/>existing\_private\_dns\_zone  = {   (Optional) If the value is provided the existing DNS Zone will be used.<br/>  name                = The name of the existing DNS Zone<br/>  resource\_group\_name = (Optional) The Name of the Resource Group where the Private DNS Zone exists. If the Name of the Resource Group is not provided, the first Private DNS Zone from the list of Private DNS Zones in your subscription that matches name will be returned.<br/>} | <pre>object({<br/>    subnet_id        = string<br/>    virtual_networks = optional(map(any), {})<br/>    existing_private_dns_zone = optional(object({<br/>      name                = string<br/>      resource_group_name = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether the public network access is enabled? | `bool` | `false` | no |
| <a name="input_queue_encryption_key_type"></a> [queue\_encryption\_key\_type](#input\_queue\_encryption\_key\_type) | (Optional) The encryption type of the queue service. Possible values are 'Service' and 'Account'.<br/>Changing this forces a new resource to be created. Default value is 'Account' | `string` | `"Account"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the storage account is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the storage account.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | (Optional) Indicates whether the storage account permits requests to be authorized with<br/>the account access key via Shared Key.<br/>If false, then all requests, including shared access signatures, must be authorized with<br/>Azure Active Directory (Azure AD)" | `bool` | `false` | no |
| <a name="input_static_error_404_document"></a> [static\_error\_404\_document](#input\_static\_error\_404\_document) | 404 Static Website | `string` | `"404.html"` | no |
| <a name="input_static_index_document"></a> [static\_index\_document](#input\_static\_index\_document) | Index Static Website | `string` | `"index.html"` | no |
| <a name="input_storage_containers"></a> [storage\_containers](#input\_storage\_containers) | The list of blob storage containers to be created | `list(string)` | `[]` | no |
| <a name="input_table_encryption_key_type"></a> [table\_encryption\_key\_type](#input\_table\_encryption\_key\_type) | (Optional) The encryption type of the table service. Possible values are 'Service' and 'Account'.<br/>Changing this forces a new resource to be created. Default value is 'Account'. | `string` | `"Account"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_primary"></a> [access\_key\_primary](#output\_access\_key\_primary) | n/a |
| <a name="output_access_key_secondary"></a> [access\_key\_secondary](#output\_access\_key\_secondary) | n/a |
| <a name="output_connection_string_primary"></a> [connection\_string\_primary](#output\_connection\_string\_primary) | n/a |
| <a name="output_connection_string_secondary"></a> [connection\_string\_secondary](#output\_connection\_string\_secondary) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_private_dns_zone"></a> [private\_dns\_zone](#output\_private\_dns\_zone) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
<!-- END_TF_DOCS -->

---

<details><summary>Samples</summary>
<br>

`private_endpoint`
~~~terraform
locals {
  vnets = {
    "vnet_1" = {
      name                = "vnet-1"
      resource_group_name = "resource-group-name-1"
    },
    "vnet_2" = {
      name                = "vnet-2"
      resource_group_name = "resource-group-name-2"
    }
  }
}


data "azurerm_virtual_network" "vnets" {
  for_each            = local.vnets
    name                = each.value.name
    resource_group_name = each.value.resource_group_name
}


data "azurerm_subnet" "Default" {
  name                 = "default"
  virtual_network_name = local.vnets.vnet_1.name
  resource_group_name  = local.vnets.vnet_1.resource_group_name
}


module "Storage_Account" {
...
  private_endpoint = {
    # A map of Virtual Networks that should be linked to the DNS Zone
    virtual_networks = data.azurerm_virtual_network.vnets
    #The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint
    subnet_id        = data.azurerm_subnet.Default.id
  }
...
}
~~~
<br>

`existing_private_dns_zone_name`
~~~terraform
module "Storage_Account" {
...
  private_endpoint = {
    existing_private_dns_zone =  {
      name = "privatelink.blob.core.windows.net"
    }
    subnet_id = data.azurerm_subnet.Default.id
  }
...
}
~~~
</details>
