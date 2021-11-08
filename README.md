# mission_terraform_aro
Terraform script to automate creation of Azure Openshift ARO.



# TERRAFORM-AZURE-ARO

Terraform script to automate creation of Azure Openshift ARO [Microsoft Azure Red Hat OpenShift (ARO)](https://www.openshift.com/products/azure-openshift)

## PREREQUISITES

* MS Azure CLI v`2.30.0`
* HashiCorp Terraform v`0.13.5`
* Red Hat pull secret from [cloud.redhat.com](https://cloud.redhat.com)

## Azure Initial CLI Setup

```bash
# Authenticate to Azure using the Azure CLI (it redirects you to the default browser on your machine to log in):
az login

# List all available Azure regions and find the one closest to you:
az account list-locations -o table

# Set the default region for Azure CLI:
az config set defaults.location=eastus

# If you have multiple Azure subscriptions, specify the relevant subscription ID:
az account set --subscription <SUBSCRIPTION_ID>

# Register the `Microsoft.RedHatOpenShift` resource provider:
az provider register -n Microsoft.RedHatOpenShift --wait

# Register the `Microsoft.Compute` resource provider:
az provider register -n Microsoft.Compute --wait

# Register the `Microsoft.Storage` resource provider:
az provider register -n Microsoft.Storage --wait
```


## Terraform Backend start up

```bash
# Run once before terraform apply, this script will create an Azure storage backend used by Terraform to store the state files
./create_backend.sh
echo "Copy the putput to backend.tf!"
```


## How to deploy this script

```bash
# Initialize Terraform:
terraform init

# See what is Terraform planning to apply:
terraform plan

# Create the resources:
terraform apply -auto-approve
```



