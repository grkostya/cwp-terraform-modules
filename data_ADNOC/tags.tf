locals {
  tags = {
    ApplicationOwner = "Rajesh Kotian"
    CreatedBy        = data.azurerm_client_config.current.object_id
    Env              = upper(local.env)
    ManagedBy        = "Terraform"
    ProjectName      = "Energy AI"
    ProjectOwner     = "Fahad Al Zarooni"
    ProjectStartDate = "17/03/2025"
    SaaS-Solution    = "Energy AI"
  }
}
