output "application_id" {
  value = azuread_application.this.application_id
}

output "password" {
  value = azuread_service_principal_password.this.value
}