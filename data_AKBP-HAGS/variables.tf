variable "environment" {
  type        = string
  description = <<-EOT
    The abbreviation of an environment name.
    Possible values are 'dev', 'uat', 'prd', 'sec', 'hub'.
  EOT

  validation {
    condition     = contains(["dev", "uat", "prd", "sec", "hub"], lower(coalesce(var.environment, terraform.workspace)))
    error_message = <<-EOT
      Invalid environment name. (Defined by the 'terraform.workspace' system variable)
      Porvided value: '${terraform.workspace}'
      Valid options are 'dev', 'uat', 'prd', 'sec', 'hub'.
    EOT
  }

  default = null
}
