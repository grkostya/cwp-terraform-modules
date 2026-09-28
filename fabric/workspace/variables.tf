variable "fabric_ws_name" {
  description = "Name of the fabric workspace"
  type        = string
}
variable "fabric_capacity_id" {
  description = "The ID of the Fabric Capacity to assign to the Workspace"
  type        = string
}


variable "fabric_users" {
  description = "Collection of users for the Fabric Workspace."
  type = list(object({
    principal = object({
      id   = string # User: Object ID, Group: Object ID, ServicePrincipal: Client ID, ServicePrincipalProfile: Client ID
      type = string # User, Group, ServicePrincipal, ServicePrincipalProfile
    })
    role = string # Admin, Member, Contributor
  }))
  default = []
}

variable "fabric_lh_name" {
  description = "Name of the fabric lakehouse(lh)"
  type        = string
}
