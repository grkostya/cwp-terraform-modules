variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the AKS cluster. Changing this forces a new resource to be created.
    location = (Required) The location/region where AKS cluster host is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the AKS cluster. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where to create the AKS cluster. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "name" {
  type        = string
  description = "(Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
}


variable "sku_tier" {
  type        = string
  description = <<-EOT
    (Optional) The SKU Tier that should be used for this Kubernetes Cluster.
    Possible values are 'Free', 'Standard' (which includes the Uptime SLA) and 'Premium'.
    Defaults to 'Standard'.
  EOT
  default     = "Standard"
}


variable "kubernetes_version" {
  type        = string
  description = <<-EOT
    (Optional) Version of Kubernetes specified when creating the AKS managed cluster.
    If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade).
    AKS does not require an exact patch version to be specified, minor version aliases such as '1.22'
    are also supported. - The minor version's latest GA patch is automatically chosen in that case.
    More details can be found in the documentation (https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli#alias-minor-version).
  EOT
  default     = null ## latest
}


variable "automatic_upgrade_channel" {
  type        = string
  description = <<-EOT
     (Optional) The upgrade channel for this Kubernetes Cluster.
     Possible values are 'patch', 'rapid', 'node-image' and 'stable'.
     Omitting this field sets this value to 'none'.
  EOT
  default     = "patch"
}


variable "disk_encryption_set_id" {
  type        = string
  description = <<-EOT
    (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes.
    More information can be found in the documentation (https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys).
    Changing this forces a new resource to be created.
  EOT
}


variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  description = <<-EOT
      type         = (Required) Specifies the type of Managed Service Identity that should be
                     configured on this Kubernetes Cluster.
                     Possible values are 'SystemAssigned' or 'UserAssigned'.
      identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to
                     this Kubernetes Cluster. This is required when type is set to 'UserAssigned'.
                     Currently only one User Assigned Identity is supported.
            NOTE:
                  type = "UserAssigned" ## To use wiht an existing private DNS zone
                  identity_ids = [azurerm_user_assigned_identity.AKS.id]
    EOT
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}


variable "azure_policy_enabled" {
  type        = bool
  description = <<-EOT
     (Optional) Should the Azure Policy Add-On be enabled?
     For more details please visit 'Understand Azure Policy for Azure Kubernetes Service'
     (https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks).
  EOT
  default     = true
}


# variable "http_application_routing_enabled" {
#   type        = bool
#   description = "(Optional) Should HTTP Application Routing be enabled?"
#   default     = false
# }


variable "web_app_routing" {
  type = object({
    dns_zone_ids             = optional(list(string), [])
    default_nginx_controller = optional(string, "AnnotationControlled")
  })
  description = <<-EOT
    dns_zone_ids             = (Required) Specifies the list of the DNS Zone IDs in which DNS entries
                                are created for applications deployed to the cluster when Web App Routing
                                is enabled. If not using Bring-Your-Own DNS zones this property should be
                                set to an empty list.
    default_nginx_controller = (Optional) Specifies the ingress type for the default NginxIngressController custom resource.
                                The allowed values are 'None', 'Internal', 'External' and 'AnnotationControlled'.
                                Defaults to 'AnnotationControlled'.
  EOT
  default     = null
}


variable "open_service_mesh_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Is Open Service Mesh enabled? For more details, please visit
    Open Service Mesh for AKS (https://docs.microsoft.com/azure/aks/open-service-mesh-about).
  EOT
  default     = false
}


variable "private_cluster_enabled" {
  type        = bool
  description = <<-EOT
     (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?
     This provides a Private IP Address for the Kubernetes API on the Virtual Network where
     the Kubernetes Cluster is located. Defaults to 'true' (Originally 'false').
     Changing this forces a new resource to be created.
  EOT
  default     = true
}


variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to 'false'"
  default     = false
}


variable "private_dns_zone_id" {
  type        = string
  description = <<-EOT
    (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster,
    'System' to have AKS manage this or 'None'.
    In case of 'None' you will need to bring your own DNS server and set up resolving, otherwise,
    the cluster will have issues after provisioning. Changing this forces a new resource to be created.
  EOT
  default     = "System"
}


# variable "virtual_network_integration_enabled" {
#   type        = bool
#   description = "(Optional) Whether to enable virtual network integration for the API Server. Defaults to 'true' (Originally 'false')"
#   default     = true
# }


# variable "authorized_ip_ranges" {
#   type        = list(string)
#   description = <<-EOT
#     (Optional) Set of authorized IP ranges to allow access to API server, e.g. ["10.0.0.0/24"].
#   EOT
#   default     = []
# }

variable "api_server_access_profile" {
  type = object({
    authorized_ip_ranges                = optional(set(string), null)
    virtual_network_integration_enabled = optional(bool, false)
    subnet_id                           = optional(string, null)
  })
  description = <<-EOT
    authorized_ip_ranges                = (Optional) Set of authorized IP ranges to allow access
                                          to API server, e.g. ["10.0.0.0/24"].
    virtual_network_integration_enabled = (Optional) Whether to enable virtual network integration
                                          for the API Server. Defaults to 'false'
    subnet_id                           = (Optional) The ID of the Subnet where the API server endpoint
                                          is delegated to.
  EOT
  default     = null
}


variable "local_account_disabled" {
  type        = bool
  description = <<-EOT
    (Optional) If 'true' local accounts will be disabled. See the documentation for more information (https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts).
    NOTE:
      If 'local_account_disabled' is set to 'true', it is required to enable Kubernetes RBAC and
      AKS-managed Azure AD integration. See the documentation for more information (https://docs.microsoft.com/azure/aks/managed-aad#azure-ad-authentication-overview).

  EOT
  default     = true
}


variable "azure_rbac_enabled" {
  type        = bool
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = false
}


variable "admin_group_object_ids" {
  type        = list(string)
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = []
}


variable "network_profile" {
  type = object({
    network_plugin      = string
    network_plugin_mode = optional(string, null)
    network_data_plane  = optional(string, "azure")
    network_policy      = optional(string, "azure")
    outbound_type       = optional(string, "loadBalancer")
  })
  description = <<-EOT
    network_plugin = (Required) Network plugin to use for networking.
                     Currently supported values are 'azure', 'kubenet' and 'none'.
                     Changing this forces a new resource to be created.
                    NOTE:
                        When 'network_plugin' is set to 'azure' - the 'pod_cidr' field must not be set,
                        unless specifying 'network_plugin_mode' to 'overlay'.
    network_policy = (Optional) Sets up network policy to be used with Azure CNI.
                      Network policy allows us to control the traffic flow between pods.
                      Currently supported values are 'calico', 'azure' and 'cilium'.
                      NOTE 1:
                          When 'network_policy' is set to 'azure', the 'network_plugin' field
                          can only be set to 'azure'.
                      NOTE 2:
                          When 'network_policy' is set to 'cilium', the 'network_data_plane' field
                          must be set to 'cilium'.
    network_plugin_mode = (Optional) Specifies the network plugin mode used for building
                          the Kubernetes network. Possible value is 'overlay'.
                          NOTE:
                              When network_plugin_mode is set to 'overlay', the 'network_plugin' field
                              can only be set to 'azure'. When upgrading from Azure CNI without overlay,
                              'pod_subnet_id' must be specified.
    network_data_plane  = (Optional) Specifies the data plane used for building the Kubernetes network.
                          Possible values are azure and cilium.
                          NOTE:
                              When network_data_plane is set to cilium, the network_plugin field can only be set to azure.
                              When network_data_plane is set to cilium, one of either network_plugin_mode = "overlay" or pod_subnet_id must be specified.
                              Upgrading network_data_plane from azure to cilium is supported and will perform an in-place upgrade by reimaging all nodes in the cluster.
                              Changing from other values will force a new resource to be created.
                              For more information on upgrading to Azure CNI Powered by Cilium see the product documentation.(https://learn.microsoft.com/en-us/azure/aks/update-azure-cni?tabs=azure-cni)
    outbound_type = (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster.
                    Possible values are 'loadBalancer', 'userDefinedRouting', 'managedNATGateway' and
                    'userAssignedNATGateway'. Defaults to 'loadBalancer'.
                    More information on supported migration paths for 'outbound_type' can be found in
                    this documentation (https://learn.microsoft.com/azure/aks/egress-outboundtype#updating-outboundtype-after-cluster-creation).
  EOT
  default = {
    network_plugin = "azure"
  }
}


variable "oms_agent" {
  type = object({
    log_analytics_workspace_id      = string
    msi_auth_for_monitoring_enabled = optional(bool, true)
    container_insights = optional(object({
      streams = optional(list(string), [
        # "Microsoft-ContainerLog",   ## Deprecated stream, should not be used when ContainerLogV2 is enabled
        "Microsoft-ContainerLogV2",
        "Microsoft-KubeEvents",
        "Microsoft-KubePodInventory",
        "Microsoft-KubeNodeInventory",
        "Microsoft-KubePVInventory",
        "Microsoft-KubeServices",
        "Microsoft-KubeMonAgentEvents",
        "Microsoft-InsightsMetrics",
        "Microsoft-ContainerInventory",
        "Microsoft-ContainerNodeInventory",
        "Microsoft-Perf"
      ])
      data_collection_endpoint_id = optional(string, null)
      data_collection_settings = optional(object({
        interval                 = optional(string, "1m")
        namespace_filtering_mode = optional(string, "Off")
        namespaces               = optional(list(string), ["kube-system", "gatekeeper-system", "azure-arc"])
        enable_container_log_v2  = optional(bool, true)
      }), {})
      transform_kql = optional(map(string), {})
    }), {})
  })
  description = <<-EOT
    log_analytics_workspace_id      = (Required) The ID of the Log Analytics Workspace which the OMS Agent should send data to.
    msi_auth_for_monitoring_enabled = (Optional) Is managed identity authentication for monitoring enabled?
    container_insights = {
      streams = (Optional) Streams used by the Container Insights data collection rule.
      data_collection_endpoint_id = (Optional) The resource ID of the Data Collection Endpoint that this rule can be used with.
      data_collection_settings = {
        interval                 = (Optional) Collection interval used by the Container Insights data collection rule.
        namespace_filtering_mode = (Optional) Namespace filtering mode used by the Container Insights extension.
        namespaces               = (Optional) Included or excluded namespaces based on namespace_filtering_mode.
        enable_container_log_v2  = (Optional) Whether ContainerLogV2 should be enabled.
      }
      transform_kql = (Optional) "Map of streams to their respective KQL transformations". E.g. transform_kql = {"Microsoft-Syslog" = "source | where severity == 'Critical'"}
    }
  EOT
  default     = null
}


variable "ingress_application_gateway" {
  type = object({
    gateway_id = string
  })
  description = <<-EOT
    gateway_id   = (Optional) The ID of the Application Gateway to integrate with
                   the ingress controller of this Kubernetes Cluster.
                   See this page for further details: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-existing .
    gateway_name = (Optional) The name of the Application Gateway to be used or created in
                   the Nodepool Resource Group, which in turn will be integrated with
                   the ingress controller of this Kubernetes Cluster.
    subnet_cidr  = (Optional) The subnet CIDR to be used to create an Application Gateway,
                   which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
    subnet_id    = (Optional) The ID of the subnet on which to create an Application Gateway, which in turn
                   will be integrated with the ingress controller of this Kubernetes Cluster.

                   See this page for further details: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new.
        NOTE 1:
            Exactly one of 'gateway_id', 'subnet_id' or 'subnet_cidr' must be specified.
        NOTE 2:
            If specifying 'ingress_application_gateway' in conjunction with 'only_critical_addons_enabled',
            the AGIC pod will fail to start. A separate 'azurerm_kubernetes_cluster_node_pool' is required
            to run the AGIC pod successfully. This is because AGIC is classed as a "non-critical addon".
  EOT
  default = {
    gateway_id = null
  }
}


variable "maintenance_window" {
  type = object({
    frequency    = string
    duration     = number
    interval     = number
    day_of_week  = string
    day_of_month = number
    start_time   = string
    utc_offset   = string
    week_index   = optional(string)
    start_date   = optional(string)
    not_allowed = optional(object({
      end   = string
      start = string
    }))
  })
  description = <<-EOT
    frequency    = (Required) Frequency of maintenance. Possible options are
                   'Weekly', 'AbsoluteMonthly' and 'RelativeMonthly'.
    interval     =  (Required) The interval for maintenance runs. Depending on the frequency this interval
                    is week or month based.
    duration     = (Required) The duration of the window for maintenance to run in hours.
                   Possible options are between 4 to 24.
    day_of_week  = (Optional) The day of the week for the maintenance run.
                    Required in combination with weekly frequency. Possible values are
                    'Friday', 'Monday', 'Saturday', 'Sunday', 'Thursday', 'Tuesday' and 'Wednesday'.
    day_of_month = (Optional) The day of the month for the maintenance run. Required in combination
                   with 'AbsoluteMonthly' frequency. Value between 0 and 31 (inclusive).
    week_index   = (Optional) The week in the month used for the maintenance run.
                   Options are 'First', 'Second', 'Third', 'Fourth', and 'Last'
    start_time   = (Optional) The time for maintenance to begin, based on the timezone determined by 'utc_offset'.
                    Format is 'HH:mm'
    utc_offset   = (Optional) Used to determine the timezone for cluster maintenance.
    start_date   = (Optional) The date on which the maintenance window begins to take effect.
    not_allowed  = { (Optional) One or more 'not_allowed' block.
      end   = (Required) The end of a time span, formatted as an RFC3339 string.
      start = (Required) The start of a time span, formatted as an RFC3339 string.
    }
  EOT
  default = {
    frequency    = "Weekly"
    interval     = 1
    duration     = 4
    day_of_week  = "Friday"
    day_of_month = 0
    start_time   = "00:00"
    utc_offset   = "+00:00"
  }
}

variable "diagnostic_setting_enabled" {
  type        = bool
  description = "Whether diagnostic settings should be enabled for the AKS cluster?"
  default     = false
}


variable "key_vault_secrets_provider" {
  type = object({
    secret_rotation_enabled  = optional(bool, false)
    secret_rotation_interval = optional(string, "2m")
  })
  description = <<-EOT
    secret_rotation_enabled  = (Optional) Should the secret store CSI driver on the AKS cluster be enabled?
    secret_rotation_interval = (Optional) The interval to poll for secret rotation.
                               This attribute is only set when 'secret_rotation_enabled' is 'true'.
                               Defaults to '2m'
        NOTE:
            To enable key_vault_sec'rets_provider either 'secret_rotation_enabled'
            or 'secret_rotation_interval' must be specified.
  EOT
  default     = null
}


variable "key_management_service" {
  type = object({
    key_vault_key_id         = string
    key_vault_network_access = optional(string, "Private")
  })
  description = <<-EOT
    (Optional) For more details, please visit [Key Management Service (KMS) etcd encryption to an AKS cluster](https://learn.microsoft.com/en-us/azure/aks/use-kms-etcd-encryption).

    key_vault_key_id         = (Required) Identifier of Azure Key Vault key. See key identifier format for more details.

    key_vault_network_access = (Optional) Network access of the key vault Network access of
                                key vault. The possible values are 'Public' and 'Private'.
                                'Public' means the key vault allows public access from all networks.
                                'Private' means the key vault disables public access and enables private link.
                                Defaults to 'Public'. For this module defaults to 'Private'
  EOT
  default     = null
}


variable "keda_enabled" {
  type        = bool
  description = "(Optional) Specifies whether KEDA Autoscaler can be used for workloads."
  default     = false
}




## System Nodepool #################################################
variable "default_node_pool" {
  type = object({
    vnet_subnet_id               = string
    vm_size                      = optional(string, "Standard_D4ds_v5")
    name                         = optional(string, "system")
    os_sku                       = optional(string, "Ubuntu")
    os_disk_type                 = optional(string, "Ephemeral")
    auto_scaling_enabled         = optional(bool, true)
    enable_host_encryption       = optional(bool, true)
    min_count                    = optional(number, 2)
    max_count                    = optional(number, 4)
    zones                        = optional(list(number), [])
    only_critical_addons_enabled = optional(bool, true)
  })
  description = <<-EOT
      NOTE:
        Changing certain properties of the 'default_node_pool' is done by cycling the system node pool
        of the cluster. When cycling the system node pool, it doesn't perform cordon and drain, and
        it will disrupt rescheduling pods currently running on the previous system node pool.
        'temporary_name_for_rotation' must be specified when changing any of the following properties:
          'host_encryption_enabled',
          'node_public_ip_enabled',
          'fips_enabled',
          'kubelet_config',
          'linux_os_config',
          'max_pods',
          'only_critical_addons_enabled',
          'os_disk_size_gb',
          'os_disk_type',
          'os_sku',
          'pod_subnet_id',
          'snapshot_id',
          'ultra_ssd_enabled',
          'vnet_subnet_id',
          'vm_size',
          'zones'.

    name = (Required) The name which should be used for the default Kubernetes Node Pool.

    vm_size = (Required) The size of the Virtual Machine, such as 'Standard_DS2_v5'.

    capacity_reservation_group_id = (Optional) Specifies the ID of the Capacity Reservation Group within which
                                    this AKS Cluster should be created.
                                    Changing this forces a new resource to be created.

    auto_scaling_enabled = (Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool?
                            NOTE:
                              - This requires that the type is set to 'VirtualMachineScaleSets'.
                              - If you're using AutoScaling, you may wish to use Terraform's 'ignore_changes'
                                functionality to ignore changes to the 'node_count' field.

    host_encryption_enabled = (Optional) Should the nodes in the Default Node Pool have host encryption enabled?
                              NOTE:
                                  This requires that the Feature 'Microsoft.ContainerService/EnableEncryptionAtHost'
                                  is enabled and the Resource Provider is registered.

    node_public_ip_enabled = (Optional) Should nodes in this Node Pool have a Public IP Address?

    gpu_instance = (Optional) Specifies the GPU MIG instance profile for supported GPU VM SKU.
                   The allowed values are 'MIG1g', 'MIG2g', 'MIG3g', 'MIG4g' and 'MIG7g'.
                   Changing this forces a new resource to be created.

    host_group_id = (Optional) Specifies the ID of the Host Group within which this AKS Cluster should be created.
                    Changing this forces a new resource to be created.

    kubelet_config = (Optional) A kubelet_config block as defined below.

    linux_os_config = (Optional) A 'linux_os_config' block.

    fips_enabled = (Optional) Should the nodes in this Node Pool have
                   Federal Information Processing Standard enabled?

    kubelet_disk_type = (Optional) The type of disk used by kubelet. Possible values are 'OS' and 'Temporary'.

    max_pods = (Optional) The maximum number of pods that can run on each agent.

    node_network_profile = (Optional) A node_network_profile block.

    node_public_ip_prefix_id = (Optional) Resource ID for the Public IP Addresses Prefix for the nodes in
                               this Node Pool. node_public_ip_enabled should be true.
                               Changing this forces a new resource to be created.

    node_labels = (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool.

    only_critical_addons_enabled = (Optional) Enabling this option will taint default node pool with
                                   'CriticalAddonsOnly=true:NoSchedule 'taint.

    orchestrator_version = (Optional) Version of Kubernetes used for the Agents.
                           If not specified, the default node pool will be created with the version
                           specified by kubernetes_version. If both are unspecified, the latest recommended
                           version will be used at provisioning time (but won't auto-upgrade).
                           AKS does not require an exact patch version to be specified,
                           minor version aliases such as '1.22' are also supported.
                           - The minor version's latest GA patch is automatically chosen in that case.
                           More details can be found in the documentation (https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli#alias-minor-version).
                      NOTE:
                          This version must be supported by the Kubernetes Cluster - as such the version
                          of Kubernetes used on the Cluster/Control Plane may need to be upgraded first.

    os_disk_size_gb = (Optional) The size of the OS Disk which should be used for each agent in the Node Pool.

    os_disk_type = (Optional) The type of disk which should be used for the Operating System.
                   Possible values are 'Ephemeral' and 'Managed'. Defaults to 'Managed'.

    os_sku = (Optional) Specifies the OS SKU used by the agent pool.
             Possible values are 'AzureLinux', 'Ubuntu', 'Windows2019' and 'Windows2022'.
             If not specified, the default is 'Ubuntu' if OSType=Linux
             or 'Windows2019' if OSType=Windows.
             And the default Windows OSSKU will be changed to 'Windows2022' after 'Windows2019' is deprecated.
             Changing this from 'AzureLinux' or 'Ubuntu' to 'AzureLinux' or 'Ubuntu' will not replace the resource,
             otherwise 'temporary_name_for_rotation' must be specified when attempting a change.

    pod_subnet_id = (Optional) The ID of the Subnet where the pods in the default Node Pool should exist.

    proximity_placement_group_id = (Optional) The ID of the Proximity Placement Group.
                                   Changing this forces a new resource to be created.

    scale_down_mode = (Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster.
                      Allowed values are 'Delete' and 'Deallocate'. Defaults to 'Delete'.

    snapshot_id - (Optional) The ID of the Snapshot which should be used to create this default Node Pool.

    temporary_name_for_rotation = (Optional) Specifies the name of the temporary node pool used to cycle
                                  the default node pool for VM resizing.

    type = (Optional) The type of Node Pool which should be created.
           Possible values are 'VirtualMachineScaleSets'. Defaults to 'VirtualMachineScaleSets'.
           Changing this forces a new resource to be created.
        NOTE:
            When creating a cluster that supports multiple node pools, the cluster must
            use 'VirtualMachineScaleSets'. For more information on the limitations of clusters using
            multiple node pools see the documentation (https://learn.microsoft.com/en-us/azure/aks/use-multiple-node-pools#limitations).

    tags = (Optional) A mapping of tags to assign to the Node Pool.

    ultra_ssd_enabled = (Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool.
                        Defaults to 'false'.
                        See the documentation for more information: https://docs.microsoft.com/azure/aks/use-ultra-disks.

    upgrade_settings = (Optional) A upgrade_settings block.

    vnet_subnet_id = (Optional) The ID of a Subnet where the Kubernetes Node Pool should exist.
                      NOTE:
                          A Route Table must be configured on this Subnet.

    workload_runtime = (Optional) Specifies the workload runtime used by the node pool.
                       Possible value is 'OCIContainer'.

    zones = (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located.
            NOTE:
                This requires that the type is set to 'VirtualMachineScaleSets' and that 'load_balancer_sku' is
                set to 'standard'.

  If 'auto_scaling_enabled' is set to 'true', then the following fields can also be configured:
    max_count = (Optional) The maximum number of nodes which should exist in this Node Pool.
                If specified this must be between 1 and 1000.
    min_count = (Optional) The minimum number of nodes which should exist in this Node Pool.
                If specified this must be between 1 and 1000.
                A minimum of 3 nodes of 8 vCPUs or 2 nodes of at least 16 vCPUs is recommended
    node_count = (Optional) The initial number of nodes which should exist in this Node Pool.
                 If specified this must be between 1 and 1000 and between 'min_count' and 'max_count'.
        NOTE:
          - If specified you may wish to use Terraform's 'ignore_changes' functionality to ignore changes
            to this field.
          - If auto_scaling_enabled is set to 'false' both 'min_count' and 'max_count' fields need to be set
            to 'null' or omitted from the configuration.
  EOT
}

variable "monitor_metrics" {
  type = object({
    annotations_allowed = optional(string, null)
    labels_allowed      = optional(string, null)
  })
  description = <<EOT
   annotations_allowed = (Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.
   labels_allowed      = (Optional) Specifies a comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.
  EOT
  default     = {}
}

variable "cost_analysis_enabled" {
  type        = bool
  description = "(Optional) Whether Cost Analysis should be enabled for the AKS cluster?"
  default     = false
}
