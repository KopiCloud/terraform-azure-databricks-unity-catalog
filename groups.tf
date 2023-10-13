# -------------------------------------
# Azure Databricks Unity Catalog Groups
# -------------------------------------

// Create a Databricks UC Group for Unity Catalog Admins
resource "databricks_group" "uc_admins" {
  provider = databricks.account

  display_name = "Unity Catalog Admins"
  
  workspace_access      = true
  databricks_sql_access = true
  
  allow_cluster_create       = true
  allow_instance_pool_create = true
}

// Create a Databricks UC Group for Data Engineers
resource "databricks_group" "uc_data_engineers" {
  provider = databricks.account

  display_name = "Data Engineers"
  
  workspace_access      = true
  databricks_sql_access = true
  
  allow_cluster_create       = false
  allow_instance_pool_create = false
}

// Create a Databricks UC Group for Data Scientists
resource "databricks_group" "uc_data_scientists" {
  provider = databricks.account

  display_name = "Data Scientists"
  
  workspace_access      = true
  databricks_sql_access = true
  
  allow_cluster_create       = false
  allow_instance_pool_create = false
}

# ---------------------------------------------
# Azure Databricks Unity Catalog Groups Members
# ---------------------------------------------

// Reference to the Terraform Service Principal
data "databricks_service_principal" "terraform_spn" {
  provider = databricks.account

  application_id = var.aad_client_id
}

// Add Terraform User to the uc_admins group
resource "databricks_group_member" "terraform" {
  provider = databricks.account

  group_id  = databricks_group.uc_admins.id
  member_id = data.databricks_service_principal.terraform_spn.id
}

# ---------------------------------
# Azure Databricks Workspace Groups
# ---------------------------------

// Create a Databricks Workspace Group for Workspaces Admins
resource "databricks_group" "workspace_admins" {
  display_name = "Workspace Admins"
  
  workspace_access      = true
  databricks_sql_access = true
  
  allow_cluster_create       = true
  allow_instance_pool_create = true
}

// Create a Databricks Workspace Group for Data Engineers
resource "databricks_group" "workspace_data_engineers" {
  display_name = "Data Engineers"
  
  workspace_access      = true
  databricks_sql_access = true
  
  allow_cluster_create       = false
  allow_instance_pool_create = false
}
