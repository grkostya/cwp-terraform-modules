variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created.
    location = (Required) The location/region where the container registry is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}

variable "adb_workspace_name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the databricks workspace.
    Only lowercase Alphanumeric characters allowed.
    Changing this forces a new resource to be created.
    This must be unique across the entire Azure service, not just within the resource group.
  EOT
  default     = "temp-adb-workspace"
}

variable "adb_managed_rg_name" {
  type        = string
  description = "(Required) Specifies the name of the managed resource group created for Databricks."
  default     = "temp-adb-managed"
}

variable "resource_group_name" {
  type        = string
  description = <<-EOT
    (Required) The name of the resource group in which to create the databricks workspace.
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
  sensitive   = false
  nullable    = false
  default     = "uaenorth"
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}

# ---------------------------------------------------------------------------------------------------------------------------
# VNET - SUBNETS
# ---------------------------------------------------------------------------------------------------------------------------

variable "vnet_id" {
  type        = string
  description = "The ID of the Subnet for Databricks compute resources."
}

variable "adb_subnet_private_id" {
  type        = string
  description = "The ID of the Private Subnet for Databricks compute resources."
}

variable "adb_subnet_private_name" {
  type        = string
  description = "The name of the Private Subnet for Databricks compute resources."
}

variable "nsg_adb_private_id" {
  type        = string
  description = "The id of the NSG for Private Subnet Databricks compute resources."
}


variable "adb_subnet_public_id" {
  type        = string
  description = "The ID of the Public Subnet for Databricks compute resources."
}

variable "adb_subnet_public_name" {
  type        = string
  description = "The ID of the Public Subnet for Databricks compute resources."
}

variable "nsg_adb_public_id" {
  type        = string
  description = "The ID of the NSG for the Public Subnet used by Databricks compute resources."
}

# ---------------------------------------------------------------------------------------------------------------------------
# ENCRYPTIONS
# ---------------------------------------------------------------------------------------------------------------------------
variable "adb_dbfs_key_vault_key_id" {
  type        = string
  description = "(Required) The resource ID of the Key Vault Key to be used."
  default     = null
}

variable "managed_services_cmk_key_vault_key_id" {
  type        = string
  description = "(Optional) Resource ID of the Key Vault which contains the managed_services_cmk_key_vault_key_id key."
  default     = null
}

variable "managed_disk_cmk_key_vault_key_id" {
  type        = string
  description = "Optional) Resource ID of the Key Vault which contains the managed_disk_cmk_key_vault_key_id key."
  default     = null
}

# ---------------------------------------------------------------------------------------------------------------------------
# STORAGE ACCOUNT FOR DATABRICKS
# ---------------------------------------------------------------------------------------------------------------------------
variable "adb_storage_account_name" {
  type        = string
  description = <<-EOT
    (Optional) Default Databricks File Storage account name.
    Only lowercase Alphanumeric characters allowed.
    Changing this forces a new resource to be created.
  EOT
}

# ---------------------------------------------------------------------------------------------------------------------------
# ADB CONNECTOR NAME
# ---------------------------------------------------------------------------------------------------------------------------
variable "adb_connector_name" {
  type        = string
  description = "(Optional) Specifies the name of the Databricks Access Connector."
  default     = "temp-adb-connector"
}
