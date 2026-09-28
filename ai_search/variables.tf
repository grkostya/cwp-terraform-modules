variable "name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the AI Search. Changing this forces a new resource to be created.
    The name must be globally unique. If the vault is in a recoverable state then
    the vault will need to be purged before reusing the name.
  EOT
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created.
    location = (Required) The location/region where the bastion host is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where the bastion host is created. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "sku" {
  description = "The pricing tier of the search service you want to create (for example, basic or standard)."
  default     = "standard"
  type        = string
  validation {
    condition     = contains(["free", "basic", "standard", "standard2", "standard3", "storage_optimized_l1", "storage_optimized_l2"], var.sku)
    error_message = "The sku must be one of the following values: free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2."
  }
}


variable "replica_count" {
  type        = number
  description = "Replicas distribute search workloads across the service. You need at least two replicas to support high availability of query workloads (not applicable to the free tier)."
  default     = 1
  validation {
    condition     = var.replica_count >= 1 && var.replica_count <= 12
    error_message = "The replica_count must be between 1 and 12."
  }
}


variable "partition_count" {
  type        = number
  description = <<-EOT
    Partitions allow for scaling of document count as well as faster indexing by sharding your
    index over multiple search units.
    NOTE:
      When 'hosting_mode' is set to 'highDensity' the maximum number of partitions allowed is '3'.
  EOT
  default     = 1
  validation {
    condition     = contains([1, 2, 3, 4, 6, 12], var.partition_count)
    error_message = "The partition_count must be one of the following values: 1, 2, 3, 4, 6, 12."
  }
}


variable "public_network_access_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Specifies whether Public Network Access is allowed for this resource.
    Defaults to 'false'
  EOT
  default     = false
}


variable "allowed_ips" {
  type        = list(string)
  description = "(Optional) A list of IP addresses or CIDR blocks which are allowed to access the search service."
  default     = null
}


variable "local_authentication_enabled" {
  type        = bool
  description = "(Optional) Specifies whether local authentication is enabled for this resource. Defaults to 'false'."
  default     = false
}


variable "semantic_search_sku" {
  type        = string
  description = <<-EOT
      (Optional) Specifies the Semantic Search SKU which should be used for this Search Service.
      Possible values include 'free' and 'standard'.
      NOTE:
        The semantic_search_sku cannot be defined if your Search Services sku is set to 'free'.
        The Semantic Search feature is only available in certain regions,
        please see the product documentation for more information.
    EOT
  default     = null
}
