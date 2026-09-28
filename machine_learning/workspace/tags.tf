resource "time_static" "now" {}


locals {
  DateCreated = formatdate("YYYY-MM-DD", time_static.now.rfc3339)

  tags = merge(
    coalesce(var.tags, try(var.resource_group.tags, null)),
    {
      DateCreated = local.DateCreated
    }
  )
}
