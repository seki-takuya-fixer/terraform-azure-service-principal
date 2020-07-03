variable "tenant_id" {
}

variable "subscription_id" {
}

variable "service_principal_name" {
  default = "sp_for_terraform"
}

variable "role" {
  default = "Contributor"
}

variable "output_file_name" {
  default = "params_sp.tfvars"
}

variable "password_end_date" {
  default = "2099-01-01T00:00:00Z"
}