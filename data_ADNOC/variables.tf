variable "environment" {
  type        = string
  description = <<-EOT
    The abbreviation of an environment name.
    Possible values are 'dev', 'uat', 'prd', 'sec'.
  EOT

  validation {
    condition     = contains(["dev", "uat", "prd", "sec"], lower(coalesce(var.environment, terraform.workspace)))
    error_message = <<-EOT
      Invalid environment name. (Defined by the 'terraform.workspace' system variable)
      Porvided value: '${terraform.workspace}'
      Valid options are 'dev', 'uat', 'prd', 'sec'.
    EOT
  }

  default = null
}


variable "get_private_DNS_zones" {
  type        = bool
  description = "Whether to get private DNS zones data"
  default     = true
}


variable "get_subnets" {
  type        = bool
  description = "Whether to get subnets data"
  default     = true
}


variable "get_vnet" {
  type        = bool
  description = "Whether to get VNet data"
  default     = false
}


variable "get_vnet_resource_group" {
  type        = bool
  description = "Whether to get VNet Resource Group data"
  default     = false
}


variable "subnet_name_suffix" {
  type        = string
  description = "The name suffix of subnets"
  default     = null
}
