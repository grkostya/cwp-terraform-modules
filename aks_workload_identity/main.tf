resource "azurerm_user_assigned_identity" "this" {
  name                = var.identity_name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
}


resource "azurerm_federated_identity_credential" "this" {
  count                     = var.federated_credential == null ? 0 : 1
  name                      = local.federation_name
  audience                  = var.federated_credential.audience
  issuer                    = var.federated_credential.oidc_issuer_url
  user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  subject                   = "system:serviceaccount:${var.k8s_namespace}:${local.k8s_service_account_name}"
}


resource "azurerm_role_assignment" "this" {
  for_each             = var.RBAC_roles
  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}


resource "kubernetes_service_account_v1" "this" {
  count = var.create_k8s_service_account == true ? 1 : 0
  metadata {
    name        = local.k8s_service_account_name
    annotations = local.annotations
    labels      = local.labels
    namespace   = var.k8s_namespace
  }
  automount_service_account_token = false
}
