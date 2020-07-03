provider "azuread" {
  version = "=0.10.0"

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

provider "azurerm" {
  version = "=2.10.0"
  features {}

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

data "azurerm_subscription" "current" {
}

module "service_principal_for_terraform" {
  source            = "../../modules/service_principal"
  name              = var.service_principal_name
  role              = var.role
  scope             = data.azurerm_subscription.current.id
  password_end_date = var.password_end_date
}

resource "local_file" "params_sp_tfvars" {
  content  = <<EOT
tenant_id = "${data.azurerm_subscription.current.tenant_id}"
subscription_id = "${data.azurerm_subscription.current.subscription_id}"
client_id = "${module.service_principal_for_terraform.application_id}"
client_secret = "${module.service_principal_for_terraform.password}"
    EOT
  filename = "${path.module}/${var.output_file_name}"
}