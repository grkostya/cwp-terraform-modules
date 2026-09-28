resource "azurerm_resource_group" "snapshots" {
  name     = local.snapshot_resource_group_name
  location = local.location
  tags     = merge(local.tags, { DateCreated = local.DateCreated })
}
