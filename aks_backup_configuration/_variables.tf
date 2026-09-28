variable "aks" {
  type = object({
    id           = string
    name         = string
    principal_id = optional(string, null)
    identity = optional(list(object({
      principal_id = string
    })), null)
  })
  description = <<-EOT
  Object containing AKS cluster information. Provide all properties when you want the module to configure role
  assignments and backup instance for an existing AKS cluster.

    id                     = Resource ID of the AKS cluster (example = azurerm_kubernetes_cluster.example.id)
    name                   = Name of the AKS cluster
    principal_id           = Principal ID (object id) of the AKS cluster managed identity (identity[0].principal_id)
  EOT
}


variable "backup_vault" {
  type = object({
    id                  = string
    name                = string
    location            = string
    resource_group_name = string
    principal_id        = optional(string, null)
    tags                = map(any)
    identity = optional(list(object({
      principal_id = string
    })), null)
  })
  description = <<-EOT
  Object containing Backup Vault information (provide all properties when the vault exists):

    id                  = Resource ID of the Data Protection Backup Vault (example = azurerm_data_protection_backup_vault.example.id)
    name                = Name of the Backup Vault (used when creating policies)
    resource_group_name = Name of the resource group where the Backup Vault exists
    principal_id        = Principal ID (object id) of the Backup Vault managed identity (identity[0].principal_id)
  EOT
}


variable "storage_account" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = <<-EOT
  Object containing Storage Account information (provide all properties when the account exists):

    id                  = Resource ID of the storage account used for backups (example = azurerm_storage_account.example.id)
    name                = Name of the storage account
    resource_group_name = Name of the resource group where the storage account exists
  EOT
}


variable "storage_container_name" {
  description = "Name of the storage container used for backups."
  type        = string
  default     = null
}


variable "snapshot_resource_group_name" {
  description = "Name of the resource group to use for snapshot resources."
  type        = string
  default     = null
}


variable "location" {
  description = "Azure location for the backup instance."
  type        = string
  default     = ""
}


variable "backup_repeating_time_intervals" {
  description = "List of ISO8601 repeating time intervals for backups (e.g. [\"R/2023-05-23T02:30:00+00:00/P1W\"])."
  type        = list(string)
  default     = []
}


variable "retention_rules" {
  type = list(object({
    name     = string
    priority = optional(number, 100)
    life_cycle = object({
      duration        = string
      data_store_type = optional(string, "OperationalStore")
    })
    criteria = optional(object({
      absolute_criteria      = optional(string, null)
      days_of_week           = optional(list(string), null)
      months_of_year         = optional(list(string), null)
      weeks_of_month         = optional(list(string), null)
      scheduled_backup_times = optional(list(string), null)
    }), {})
  }))
  description = <<-EOT
    List of retention rule objects matching the backup policy retention_rule blocks

      name       = Name of the retention rule
      priority   = (Optional) Priority of the retention rule (default = 100)
      life_cycle = Map containing life_cycle information:
        duration        = ISO8601 duration string for the retention period (example = "P14D" for 14 days)
        data_store_type = Type of data store for retention (example = "OperationalStore")
      criteria = (Optional) Map containing criteria information:
        absolute_criteria      = (Optional) Possible values are 'AllBackup', 'FirstOfDay', 'FirstOfWeek',
                                 'FirstOfMonth' and 'FirstOfYear'. These values mean the first successful
                                 backup of the day/week/month/year. Changing this forces a new resource to be created.
        days_of_week           = (Optional) List of days of the week for retention (example = ["Sunday"])
        months_of_year         = (Optional) List of months of the year for retention (example = ["November"])
        weeks_of_month         = (Optional) Possible values are 'First', 'Second', 'Third', 'Fourth' and
                                 'Last'. Changing this forces a new resource to be created.
                                 (example = ["First"])
        scheduled_backup_times = (Optional) Specifies a list of backup times for retention in the RFC3339 format.
                                 (example = ["2023-05-23T02:30:00Z"])

    Note:
      When not using 'absolute_criteria', you must use exactly one of 'days_of_month' or 'days_of_week'.
      Regarding the remaining two properties, 'weeks_of_month' and 'months_of_year', you may use either,
      both, or neither. If you would like to set multiple intervals, you may do so by using
      multiple 'retention_rule' blocks.
  EOT
  default     = []
}


variable "default_retention_life_cycle" {
  type        = any
  description = <<-EOT
  Map containing default retention life_cycle information. Provide all properties to configure the default retention settings for backups.

    duration        = ISO8601 duration string for the retention period (example = "P14D" for 14 days)
    data_store_type = Type of data store for retention (example = "OperationalStore")
  EOT
  default = {
    duration        = "P14D"
    data_store_type = "OperationalStore"
  }
}


variable "included_namespaces" {
  type    = list(string)
  default = []
}


variable "excluded_namespaces" {
  type    = list(string)
  default = []
}


variable "included_resource_types" {
  type    = list(string)
  default = []
}


variable "excluded_resource_types" {
  type    = list(string)
  default = []
}


variable "label_selectors" {
  type    = list(string)
  default = []
}


variable "cluster_scoped_resources_enabled" {
  type    = bool
  default = true
}


variable "volume_snapshot_enabled" {
  type    = bool
  default = true
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}
