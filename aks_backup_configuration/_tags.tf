resource "time_static" "now" {}

locals {
  DateCreated = formatdate("YYYY-MM-DD", time_static.now.rfc3339)

  tags = merge(
    var.backup_vault.tags,
    try(var.tags, {}),
    {
      DateCreated = local.DateCreated
    }
  )
}
