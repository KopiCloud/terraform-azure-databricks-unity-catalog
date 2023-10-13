# ----------------------------------------
# Azure Databricks Unity Catalog Metastore
# ----------------------------------------

// Create the Databricks Metastore
resource "databricks_metastore" "primary" {
  provider = databricks.workspace

  name         = "primary"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/", azurerm_storage_container.unity_catalog.name, module.storage_account_unity_catalog.name)
  force_destroy = true
  region        = var.location
  owner         = databricks_group.uc_admins.display_name

  depends_on = [ 
    module.storage_account_unity_catalog,
    azurerm_storage_container.unity_catalog
  ]
}

// Assign Metastore to the Workspace
resource "databricks_metastore_assignment" "primary" {
  provider = databricks.workspace

  workspace_id         = var.databricks_workspace_id
  metastore_id         = databricks_metastore.primary.id
  default_catalog_name = "hive_metastore"

  depends_on = [ databricks_metastore.primary ]
}

// Each databricks_metastore requires a managed identity that will be assumed by Unity Catalog to access data. 
resource "databricks_metastore_data_access" "primary" {
  provider = databricks.workspace

  metastore_id = databricks_metastore.primary.id
  name         = "primary"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.unity.id
  }

  is_default = true

  depends_on = [ 
    azurerm_databricks_access_connector.unity, 
    databricks_metastore.primary, 
    databricks_metastore_assignment.primary 
  ]
}

// Assign Permissions to the Terraform Service Principal
resource "databricks_grants" "primary" {
  provider = databricks.workspace
  
  metastore = databricks_metastore.primary.id
  grant {
    principal  = var.aad_client_id
    privileges = ["CREATE_CATALOG", "CREATE_EXTERNAL_LOCATION"]
  }

  depends_on = [ databricks_metastore_data_access.primary ]
}
