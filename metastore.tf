# ----------------------------------------
# Azure Databricks Unity Catalog Metastore
# ----------------------------------------

// Create the Databricks Metastore
resource "databricks_metastore" "primary" {
  name         = "primary"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/", azurerm_storage_container.unity_catalog.name, azurerm_storage_account.unity_catalog.name)
  force_destroy = true
  region        = var.location

  depends_on = [ 
    azurerm_storage_container.unity_catalog, 
    azurerm_storage_account.unity_catalog 
  ]
}

// Assign Metastore to the Workspace
resource "databricks_metastore_assignment" "primary" {
  workspace_id         = var.databricks_workspace_id
  metastore_id         = databricks_metastore.primary.id
  default_catalog_name = "hive_metastore"

  depends_on = [ databricks_metastore.primary ]
}

// Each databricks_metastore requires a managed identity that Unity Catalog will assume to access data. 
resource "databricks_metastore_data_access" "primary" {
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

