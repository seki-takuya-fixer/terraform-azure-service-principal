# terraform-azure-service-principal

Terraform: create new azure service principal

# Requirements

- Terraform v0.12.26
- azure-cli 2.7.0

# Procedure

1. change directory

   ```Batchfile
   cd terraform\projects\service_principal
   ```

1. login to Azure

   ```Batchfile
   az login
   ```

1. create parameter file

   params.tfvars

   ```Batchfile
   tenant_id="<Tenant ID>"
   subscription_id="<Subscription ID>"
   ```

1. create Azure resources

   ```Batchfile
   terraform init
   terraform plan --var-file params.tfvars
   terraform apply --var-file params.tfvars
   ```

1. The service principal's parameters are output to params_sp.tfvars
