variable "name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the storage account.
    Only lowercase Alphanumeric characters allowed.
    Changing this forces a new resource to be created.
    This must be unique across the entire Azure service, not just within the resource group.
  EOT
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created.
    location = (Required) The location/region where the storage account is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = <<-EOT
    (Required) The name of the resource group in which to create the storage account.
    Changing this forces a new resource to be created.
  EOT
  default     = null
}


variable "location" {
  type        = string
  description = <<-EOT
    (Required) Specifies the supported Azure location where the resource exists.
    Changing this forces a new resource to be created.
  EOT
  default     = null
}


variable "account_kind" {
  type        = string
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  default     = "StorageV2"
}


variable "account_tier" {
  type        = string
  description = <<-EOF
    (Required) Defines the Tier to use for this storage account. Valid options are 'Standard' and 'Premium'.
    For 'BlockBlobStorage' and 'FileStorage' accounts only 'Premium' is valid.
    Changing this forces a new resource to be created.
  EOF
  default     = "Standard"
}


variable "account_replication_type" {
  type        = string
  description = <<-EOT
    (Required) Defines the type of replication to use for this storage account.
    Valid options are 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS' and 'RAGZRS'.
    Changing this forces a new resource to be created when types 'LRS', 'GRS' and 'RAGRS' are changed to
    'ZRS', 'GZRS' or 'RAGZRS' and vice versa.
  EOT
  default     = "LRS"
}


variable "cross_tenant_replication_enabled" {
  type        = bool
  description = "(Optional) Should cross Tenant replication be enabled?"
  default     = false
}


variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether the public network access is enabled?"
  default     = false
}


variable "shared_access_key_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Indicates whether the storage account permits requests to be authorized with
    the account access key via Shared Key.
    If false, then all requests, including shared access signatures, must be authorized with
    Azure Active Directory (Azure AD)"
  EOT
  default     = false
}


variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public."
  default     = false
}


variable "blob_delete_retention_policy_days" {
  type        = number
  description = "(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days."
  default     = 7
}


variable "blob_container_delete_retention_policy_days" {
  type        = number
  description = "(Optional) Specifies the number of days that the container should be retained, between 1 and 365 days."
  default     = 7
}


variable "nfsv3_enabled" {
  type        = bool
  description = <<-EOT
    "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created"
    NOTE:
    This can only be true when account_tier is 'Standard' and account_kind is 'StorageV2',
    or account_tier is 'Premium' and account_kind is 'BlockBlobStorage'.
    Additionally, the 'is_hns_enabled' is 'true' and 'account_replication_type' must be 'LRS' or 'RAGRS'.
  EOT
  default     = false
}


variable "is_hns_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2.
    Changing this forces a new resource to be created.
    NOTE:
    This can only be true when 'account_tier' is 'Standard'
    or when 'account_tier' is 'Premium' and 'account_kind' is 'BlockBlobStorage'
  EOT
  default     = false
}


variable "enable_static_website" {
  description = "Enable static website hosting"
  type        = bool
  default     = false
}


variable "static_index_document" {
  description = "Index Static Website"
  type        = string
  default     = "index.html"
}


variable "static_error_404_document" {
  description = "404 Static Website"
  type        = string
  default     = "404.html"
}


variable "default_to_oauth_authentication" {
  type        = bool
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account."
  default     = true
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "storage_containers" {
  type        = list(string)
  description = "The list of blob storage containers to be created"
  default     = []
}


variable "network_rules" {
  type = object({
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(set(string))
    virtual_network_subnet_ids = optional(set(string))
    bypass                     = optional(set(string), ["None"]) ## ["AzureServices", "Metrics", ]
  })
  description = <<-EOT
    default_action             = (Required) Specifies the default action of allow or deny when no other rules match.
                                  Valid options are 'Deny' or 'Allow'.
    ip_rules                   = (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed.
                                  Private IP address ranges are not allowed.
                                  NOTE 1:
                                  Small address ranges using "/31" or "/32" prefix sizes are not supported.
                                  These ranges should be configured using individual IP address rules without prefix specified.
                                  NOTE 2:
                                  IP network rules have no effect on requests originating from the same Azure region
                                  as the storage account. Use Virtual network rules to allow same-region requests.
                                  Services deployed in the same region as the storage account use private Azure IP addresses
                                  for communication. Thus, you cannot restrict access to specific Azure services based on their
                                  public outbound IP address range.
                                  NOTE 3:
                                  User has to explicitly set ip_rules to empty slice ([]) to remove it.
    virtual_network_subnet_ids = (Optional) A list of virtual network subnet ids to secure the storage account.
                                  NOTE:
                                  User has to explicitly set virtual_network_subnet_ids to empty slice ([]) to remove it.
    bypass                     = (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices.
                                  Valid options are any combination of 'Logging', 'Metrics', 'AzureServices', or 'None'.
                                  NOTE:
                                  User has to explicitly set bypass to empty slice ([]) to remove it.
  EOT
  default     = {}
}


variable "identity" {
  type = object({
    type         = string
    identity_ids = set(string)
  })
  description = <<-EOT
    type         = (Required) Specifies the type of Managed Service Identity
                   that should be configured on this Storage Account.
                   Possible values are 'SystemAssigned', 'UserAssigned',
                   'SystemAssigned, UserAssigned' (to enable both).
    identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs
                    to be assigned to this Storage Account.
                    This is required when type is set to 'UserAssigned' or 'SystemAssigned, UserAssigned'.
    NOTE:
    The assigned prin'cipal_id and 'tenant_id' can be retrieved after the identity 'type'
    has been set to 'SystemAssigned' and Storage Account has been created.
  EOT
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}


variable "customer_managed_key" {
  type = object({
    key_vault_key_id          = optional(string)
    managed_hsm_key_id        = optional(string)
    user_assigned_identity_id = string
  })
  description = <<-EOT
    block supports the following:

      key_vault_key_id          = (Optional) The ID of the Key Vault Key,
                                  supplying a version-less key ID will enable auto-rotation of this key.
      managed_hsm_key_id        = (Optional) The ID of the managed HSM Key.
      user_assigned_identity_id = (Required) The ID of a user assigned identity.
      NOTE:
      'customer_managed_key' can only be set when the 'account_kind' is set to 'StorageV2'
      or 'account_tier' set to 'Premium', and the 'identity' type is 'UserAssigned'.
      Exactly one of 'key_vault_key_id' and 'managed_hsm_key_id' may be specified.
  EOT
  default     = null
}


variable "infrastructure_encryption_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Is infrastructure encryption enabled?
    Changing this forces a new resource to be created. Defaults to 'true'.
    NOTE:
    This can only be true when 'account_kind' is 'StorageV2'
    or when 'account_tier' is 'Premium' and 'account_kind' is one of 'BlockBlobStorage' or 'FileStorage'.
  EOT
  default     = true
}


variable "queue_encryption_key_type" {
  type        = string
  description = <<-EOT
    (Optional) The encryption type of the queue service. Possible values are 'Service' and 'Account'.
    Changing this forces a new resource to be created. Default value is 'Account'
  EOT
  default     = "Account"
}


variable "table_encryption_key_type" {
  type        = string
  description = <<-EOT
    (Optional) The encryption type of the table service. Possible values are 'Service' and 'Account'.
    Changing this forces a new resource to be created. Default value is 'Account'.
  EOT
  default     = "Account"
}


variable "blob_cors_rule" {
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  description = <<-EOT
    (Optional) A list of CORS rules. Each rule allows origins and methods.
    Each rule must have the following fields:
      allowed_headers     = (Required) List of headers allowed to be part of the CORS request.
      allowed_methods     = (Required) A list of HTTP methods that are allowed to be executed by the origin.
                             Valid options are 'DELETE', 'GET', 'HEAD', 'MERGE', 'POST', 'OPTIONS', 'PUT' or 'PATCH'.
      allowed_origins     = (Required) A list of origin domains that will be allowed by CORS.
      exposed_headers     = (Required) A list of response headers that are exposed to CORS clients.
      max_age_in_seconds  = (Required) The number of seconds that the client/browser should cache a preflight request.
  EOT
  default     = []
}


variable "allowed_copy_scope" {
  type        = string
  description = <<-EOT
    (Optional) Restrict copy to and from Storage Accounts within an AAD tenant or
    with Private Links to the same VNet. Possible values are 'AAD' and 'PrivateLink'.
  EOT
  default     = "AAD"
}




#########################################################
### Private Endpoint

variable "private_endpoint" {
  type = object({
    subnet_id        = string
    virtual_networks = optional(map(any), {})
    existing_private_dns_zone = optional(object({
      name                = string
      resource_group_name = optional(string)
    }))
  })
  description = <<-EOT
    subnet_id                  = The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created.
    virtual_networks           = A map of Virtual Network data references. Required to get Virtual Network IDs that should be linked to the DNS Zone. Changing this forces a new resource to be created.
    existing_private_dns_zone  = {   (Optional) If the value is provided the existing DNS Zone will be used.
      name                = The name of the existing DNS Zone
      resource_group_name = (Optional) The Name of the Resource Group where the Private DNS Zone exists. If the Name of the Resource Group is not provided, the first Private DNS Zone from the list of Private DNS Zones in your subscription that matches name will be returned.
    }
  EOT
  default     = null
}
