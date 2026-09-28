variable "name" {
  type        = string
  description = <<-EOT
    (Required) The name which should be used for this PostgreSQL Flexible Server.
    Changing this forces a new PostgreSQL Flexible Server to be created.
    NOTE:
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
    name     = (Required) The name of the resource group in which to create the PostgreSQL Flexible Server. Changing this forces a new resource to be created.
    location = (Required) The Azure Region where the PostgreSQL Flexible Server is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = <<-EOT
    (Required) The name of the Resource Group where the PostgreSQL Flexible Server should exist.
    Changing this forces a new PostgreSQL Flexible Server to be created.
  EOT
  default     = null
}


variable "location" {
  type        = string
  description = <<-EOT
    (Required) The Azure Region where the PostgreSQL Flexible Server should exist.
    Changing this forces a new PostgreSQL Flexible Server to be created.
  EOT
  default     = null
}


variable "backup_retention_days" {
  type        = number
  description = <<-EOT
     (Optional) The backup retention days for the PostgreSQL Flexible Server.
     Possible values are between 7 and 35 days.
  EOT
  default     = 7
}


variable "pg_version" {
  type        = string
  description = <<-EOT
    (Optional) The version of PostgreSQL Flexible Server to use.
    Possible values are 11, 12, 13, 14, 15 and 16.
    Required when 'create_mode' is 'Default'.
    NOTE:
    When 'create_mode' is 'Update', upgrading version wouldn't force a new resource to be created.
  EOT
}


variable "sku_name" {
  type        = string
  description = <<-EOT
    (Optional) The SKU Name for the PostgreSQL Flexible Server.
    The name of the SKU, follows the 'tier' + 'name' pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3)
  EOT
}


variable "storage" {
  type = object({
    mb   = number
    tier = string
  })
  description = <<-EOT
    mb   = (Optional) The max storage allowed for the PostgreSQL Flexible Server.
                      Possible values are '32768', '65536', '131072', '262144', '524288', '1048576', '2097152',
                      '4193280', '4194304', '8388608', '16777216' and '33553408'.
                      Note:
                      If the 'storage_mb' field is undefined on the initial deployment of the PostgreSQL
                      Flexible Server resource it will default to '32768'.
                      If the 'storage_mb' field has been defined and then removed, the 'storage_mb'
                      field will retain the previously defined value.
                      The 'storage_mb' can only be scaled up, for example,
                      you can scale the storage_mb from '32768' to '65536', but not from '65536' to '32768'.
    tier = (Optional) The name of storage performance tier for IOPS of the PostgreSQL Flexible Server.
                      Possible values are 'P4', 'P6', 'P10', 'P15', 'P20', 'P30', 'P40', 'P50', 'P60', 'P70' or 'P80'.
                      Default value is dependant on the 'storage_mb' value.
                      Please see the 'storage_tier' defaults based on 'storage_mb' table in docs.
                      https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server
                      Note:
                      The storage_tier can be scaled once every 12 hours, this restriction is in place to ensure
                      stability and performance after any changes to your PostgreSQL Flexible Server's configuration.
  EOT
  default = {
    mb   = 32768
    tier = "P4"
  }
}


variable "auto_grow_enabled" {
  type        = bool
  description = "(Optional) Is the storage auto grow enabled? Defaults to 'false'."
  default     = false
}


# Private access (VNet integration)
variable "delegated_subnet" {
  type = object({
    name                 = optional(string, "postgresql")
    virtual_network_name = string
    resource_group_name  = string
    address_prefixes     = optional(list(string), ["10.0.2.0/24"])
  })
  description = "(Optional) The values to create the virtual network delegated subnet for the private PostgreSQL Flexible Server."
  default     = null
}


# Public access (allowed IP addresses)
variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "default_database_administrator_object_ids" {
  type        = map(set(string))
  description = <<-EOT
    The map of sets of object IDs of users, service principals or security groups
    in the Azure Active Directory tenant set as the Flexible Server Admin.
    Changing this forces a new resource to be created."
    EXAMPLE:
    default_database_administrator_object_ids = {
      User = ["00000000-0000-0000-0000-000000000000",]
      Group = []
      ServicePrincipal = []
    }
  EOT
  default = {
    User             = []
    Group            = []
    ServicePrincipal = []
  }
}


variable "firewall_rules" {
  type        = map(map(string))
  description = <<-EOT
    EXAMPLE:
    name = {  (Required) The name which should be used for this PostgreSQL Flexible Server Firewall Rule. Changing this forces a new PostgreSQL Flexible Server Firewall Rule to be created.
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  EOT
  default     = {}
}

variable "firewall_rule_CIDRs" {
  type        = list(string)
  description = <<-EOT
    Provide the list of allowed internet address ranges by using CIDR notation in the form "0.0.0.0/24"
    or as individual IP addresses like  "0.0.0.0"
    EXAMPLE:
    firewall_rule_CIDRs = ["1.1.1.0/24", "0.0.0.0", ]
  EOT
  default     = []
}


variable "password_auth_enabled" {
  type        = bool
  description = "(Optional) Whether or not password authentication is allowed to access the PostgreSQL Flexible Server."
  default     = false
}


variable "administrator_login" {
  type        = string
  description = "(Optional) The Administrator login for the PostgreSQL Flexible Server. Required when 'create_mode' is 'Default' and 'authentication.password_auth_enabled' is 'true'."
  default     = null
}


variable "administrator_password" {
  type        = string
  description = "(Optional) The Password associated with the 'administrator_login' for the PostgreSQL Flexible Server. Required when 'create_mode' is 'Default' and 'authentication.password_auth_enabled' is 'true'."
  default     = null
}


variable "identity" {
  type = object({
    type         = string
    identity_ids = set(string)
  })
  description = <<-EOT
    type         = (Required) Specifies the type of Managed Service Identity that should be configured on
                   this PostgreSQL Flexible Server. The only possible value is 'UserAssigned'
    identity_ids = (Required) A list of User Assigned Managed Identity IDs to be assigned to
                   this PostgreSQL Flexible Server. Required if used together with 'customer_managed_key' block.
  EOT
  default     = null
}


variable "customer_managed_key" {
  type = object({
    key_vault_key_id                     = string
    primary_user_assigned_identity_id    = optional(string)
    geo_backup_key_vault_key_id          = optional(string)
    geo_backup_user_assigned_identity_id = optional(string)
  })
  description = <<-EOT
    block supports the following:

      key_vault_key_id                     = (Required) The ID of the Key Vault Key.
      primary_user_assigned_identity_id    = (Optional) Specifies the primary user managed identity id
                                             for a Customer Managed Key. Should be added with identity_ids.
      geo_backup_key_vault_key_id          = (Optional) The ID of the geo backup Key Vault Key.
                                             It can't cross region and need Customer Managed Key in
                                             same region as geo backup.
      geo_backup_user_assigned_identity_id = (Optional) The geo backup user managed identity id
                                             for a Customer Managed Key. Should be added with 'identity_ids'.
                                             It can't cross region and need identity in same region as geo backup.
      NOTE:
      'primary_user_assigned_identity_id' or 'geo_backup_user_assigned_identity_id' is required when 'type'
      is set to 'UserAssigned'.
  EOT
  default     = null
}


variable "existing_private_dns_zone_id" {
  type        = string
  description = "(Optional) The ID of the Private DNS Zone to register a private endpoint's IP."
  default     = null
}


variable "existing_delegated_subnet_id" {
  type        = string
  description = <<-EOT
    (Optional) The ID of the virtual network subnet to create the PostgreSQL Flexible Server.
    The provided subnet should not have any other resource deployed in it and this subnet will be delegated
    to the PostgreSQL Flexible Server, if not already delegated. Changing this forces
    a new PostgreSQL Flexible Server to be created
  EOT
  default     = null
}
