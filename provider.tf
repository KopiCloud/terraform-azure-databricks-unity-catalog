# -----------------------
# Azure Provider - Main #
# -----------------------

# Define Terraform provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
}

# Define the Azure provider
provider "azurerm" {
  client_id       = var.aad_client_id
  client_secret   = var.aad_client_secret
  tenant_id       = var.aad_tenant_id
  subscription_id = var.aad_subscription_id
  features {}
}

# Define the Databricks Workspace provider
provider "databricks" {
  host                = var.databricks_workspace_url
  azure_client_id     = var.aad_client_id
  azure_tenant_id     = var.aad_tenant_id
  azure_client_secret = var.aad_client_secret
}

# Define the Databricks Account provider
provider "databricks" {
  alias = "account"
  
  host                = "https://accounts.azuredatabricks.net"
  account_id          = var.databricks_account_id 
  azure_client_id     = var.aad_client_id
  azure_tenant_id     = var.aad_tenant_id
  azure_client_secret = var.aad_client_secret
}