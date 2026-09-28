

variable "name" {
  type        = string
  description = <<-EOT
      (Required) The name of the Node Pool which should be created within the Kubernetes Cluster.
      Changing this forces a new resource to be created.
      NOTE:
        A Windows Node Pool cannot have a name longer than 6 characters.
    EOT
  default     = "user"

  validation {
    condition     = length(regexall("^[a-z0-9]+$", var.name)) > 0 && (contains(["Windows2022", "Windows2019"], var.os_sku) ? length(var.name) < 7 : length(var.name) < 13)
    error_message = <<-EOT
      Invalid name.
      - AKS node pool names must be all lowercase.
      - The names must be 1-12 characters in length for Linux node pools and 1-6 characters for Windows node pools.
      - A name must start with a letter, and the only allowed characters are letters and numbers.
    EOT
  }
}


variable "kubernetes_cluster_id" {
  type        = string
  description = <<-EOT
        (Required) The ID of the Kubernetes Cluster where this Node Pool should exist.
        Changing this forces a new resource to be created.
        NOTE:
            The type of Default Node Pool for the Kubernetes Cluster must be
            'VirtualMachineScaleSets' to attach multiple node pools.
    EOT
}


variable "vm_size" {
  type        = string
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this property requires specifying 'temporary_name_for_rotation'."
  default     = "Standard_D4ds_v5"
}


variable "auto_scaling_enabled" {
  type        = string
  description = "(Optional) Whether to enable auto-scaler (https://docs.microsoft.com/azure/aks/cluster-autoscaler)."
  default     = true
}


variable "host_encryption_enabled" {
  type        = bool
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Changing this property requires specifying 'temporary_name_for_rotation'."
  default     = true
}


variable "max_pods" {
  type        = string
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this property requires specifying 'temporary_name_for_rotation'"
  default     = 30
}


variable "mode" {
  type        = string
  description = <<-EOT
    (Optional) Should this Node Pool be used for System or User resources?
    Possible values are 'System' and 'User'. Defaults to 'User'.
  EOT
  default     = "User"
}


variable "node_labels" {
  type        = map(string)
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool."
  default     = {}
}


variable "node_taints" {
  type        = list(string)
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g ['key=value:NoSchedule'])."
  default     = []
}


variable "os_disk_size_gb" {
  type        = number
  description = "(Optional) The Agent Operating System disk size in GB. Changing this property requires specifying temporary_name_for_rotation."
  default     = 128
}


variable "os_disk_type" {
  type        = string
  description = <<-EOT
      (Optional) The type of disk which should be used for the Operating System.
      Possible values are 'Ephemeral' and 'Managed'. Defaults to 'Managed'.
      Changing this property requires specifying 'temporary_name_for_rotation'.
    EOT
  default     = "Managed"
}


variable "pod_subnet_id" {
  type        = string
  description = "(Optional) The ID of the Subnet where the pods in the Node Pool should exist. Changing this property requires specifying 'temporary_name_for_rotation'."
  default     = null
}


variable "os_sku" {
  type        = string
  description = <<-EOT
       (Optional) Specifies the OS SKU used by the agent pool. Possible values are
       'AzureLinux', 'Ubuntu', 'Windows2019' and 'Windows2022'. If not specified, the default is
       'Ubuntu' if OSType=Linux
       or 'Windows2019' if OSType=Windows.
       And the default Windows OSSKU will be changed to 'Windows2022' after 'Windows2019' is deprecated.
       Changing this from 'AzureLinux' or 'Ubuntu' to 'AzureLinux' or 'Ubuntu' will not replace the resource,
       otherwise it forces a new resource to be created.
    EOT
  default     = "Ubuntu"
}


# variable "os_type" {
#   type = string
#   description = <<-EOT
#     (Optional) The Operating System which should be used for this Node Pool.
#     Changing this forces a new resource to be created.
#     Possible values are 'Linux' and 'Windows'. Defaults to 'Linux'.
#   EOT
#   default = "Linux"
# }


variable "priority" {
  type        = string
  description = <<-EOT
    (Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool.
     Possible values are 'Regular' and 'Spot'. Defaults to 'Regular'.
     Changing this forces a new resource to be created.
  EOT
  default     = "Regular"
}


variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}


variable "vnet_subnet_id" {
  type        = string
  description = "(Optional) The ID of the Subnet where this Node Pool should exist. Changing this property requires specifying 'temporary_name_for_rotation'."
}


variable "zones" {
  type        = list(number)
  description = <<-EOT
    (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool
    should be located. Changing this property requires specifying 'temporary_name_for_rotation'.
  EOT
  default     = []
}


variable "max_count" {
  type        = number
  description = <<-EOT
      (Optional) The maximum number of nodes which should exist within this Node Pool.
      Valid values are between 0 and 1000 and must be greater than or equal to 'min_count'.
    EOT
  default     = 4
}


variable "min_count" {
  type        = number
  description = <<-EOT
      (Optional) The minimum number of nodes which should exist within this Node Pool.
      Valid values are between 0 and 1000 and must be less than or equal to 'max_count'.
    EOT
  default     = 1
}


variable "node_count" {
  type        = number
  description = <<-EOT
      (Optional) The initial number of nodes which should exist within this Node Pool.
      Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive)
      for system pools and must be a value in the range 'min_count' - 'max_count'.
    EOT
  default     = 1
}


variable "gpu_driver" {
  type        = string
  description = <<-EOT
    (Optional) Specifies whether to install the GPU Driver for the nodes.
    Possible values are 'Install' and 'None'. Changing this forces a new resource to be created.
  EOT
  default     = null
}


variable "gpu_instance" {
  type        = string
  description = <<-EOT
    (Optional) Specifies the GPU MIG instance profile for supported GPU VM SKU.
    The allowed values are 'MIG1g', 'MIG2g', 'MIG3g', 'MIG4g' and 'MIG7g'.
    Changing this forces a new resource to be created.
  EOT
  default     = null
}


variable "upgrade_settings" {
  type = object({
    drain_timeout_in_minutes      = optional(number, 0)
    max_surge                     = optional(string) ##"10%"
    max_unavailable               = optional(string)
    node_soak_duration_in_minutes = optional(number, 0)
  })
  description = <<-EOT
    drain_timeout_in_minutes      = (Optional) The amount of time in minutes to wait
                                    on eviction of pods and graceful termination per node.
                                    This eviction wait time honors waiting on
                                    pod disruption budgets. If this time is exceeded,
                                    the upgrade fails. Unsetting this after configuring it
                                    will force a new resource to be created.
    max_surge                     = (Required) The maximum number or percentage of nodes
                                    which will be added to the Node Pool size during an upgrade.
    max_unavailable               = (Optional) The maximum number or percentage of nodes which
                                    can be unavailable during the upgrade.
    node_soak_duration_in_minutes = (Optional) The amount of time in minutes to wait
                                    after draining a node and before reimaging and moving on to next node.

    NOTE:
      Exactly one of 'max_surge' or 'max_unavailable' must be specified.
  EOT
  default = {
    max_surge = "10%"
  }
}


variable "node_public_ip_enabled" {
  type        = bool
  description = <<-EOT
      (Optional) Should each node have a Public IP Address?
      Changing this property requires specifying 'temporary_name_for_rotation'.
  EOT
  default     = false
}

variable "ultra_ssd_enabled" {
  type        = bool
  description = <<-EOT
      (Optional) Should the ultra disk be accessible?
  EOT
  default     = false
}

variable "fips_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Should the nodes in this Node Pool have
    Federal Information Processing Standard enabled?
    Changing this property requires specifying 'temporary_name_for_rotation'.
  EOT
  default     = false
}
