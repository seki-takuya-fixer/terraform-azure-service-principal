resource "azuread_application" "this" {
  name                       = var.name
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

resource "azuread_service_principal" "this" {
  depends_on = [azuread_application.this]

  application_id = azuread_application.this.application_id
}

resource "random_string" "this" {
  length           = 16
  special          = true
  override_special = "@#$%^&*-_!+=[]{}|\\:',.?/`~\"();"
}

resource "azuread_service_principal_password" "this" {
  depends_on = [azuread_application.this, random_string.this]

  service_principal_id = azuread_service_principal.this.id
  description          = "rbac"
  value                = random_string.this.result
  end_date             = var.password_end_date
}

data "azurerm_role_definition" "this" {
  name = var.role
}

resource "azurerm_role_assignment" "this" {
  depends_on = [azuread_service_principal.this]

  scope              = var.scope
  role_definition_id = data.azurerm_role_definition.this.id
  principal_id       = azuread_service_principal.this.id

  lifecycle {
    ignore_changes = [
      role_definition_id,
    ]
  }
}