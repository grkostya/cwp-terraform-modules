locals {
  min_count  = var.auto_scaling_enabled ? var.min_count : null
  max_count  = var.auto_scaling_enabled ? var.max_count : null
  node_count = var.auto_scaling_enabled ? null : var.node_count

  name = contains(["Windows2022", "Windows2019"], var.os_sku) ? substr(var.name, 0, 6) : substr(var.name, 0, 12)
}
