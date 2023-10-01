# ------------------------
# Authentication Variables
# ------------------------

variable "aad_tenant_id" {
  type        = string
  description = "The id of the Azure Tenant to which all subscriptions belong"
}

variable "aad_subscription_id" {
  type        = string
  description = "The id of the Azure Subscription"
}

variable "aad_client_id" {
  type        = string
  description = "The client id of the Service Principal for interacting with Azure resources"
}

variable "aad_client_secret" {
  type        = string
  description = "The client secret of the Service Principal for interacting with Azure resources"
  sensitive   = true
}

# ---------------------
# Application Variables
# ---------------------

# Company name 
variable "company" {
  type        = string
  description = "This variable defines the company name used to build resources"
}

# Application name 
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# Environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

# Azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "west europe"
}

# Azure short region
variable "shortlocation" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "we"
}

# --------------------
# Databricks Variables
# --------------------

variable "databricks_workspace_rg" {
  type        = string
  description = "The existing Resource Group where Databricks Workspace was deployed"
}

variable "databricks_workspace_id" {
  type        = string
  description = "The ID of the Databricks Workspace for this deployment"
}

variable "databricks_workspace_url" {
  type        = string
  description = "The URL of the Databricks Workspace for this deployment"
}

variable "databricks_account_id" {
  type        = string
  description = "The ID of the Databricks Account for this deployment"
  default      = ""
}
