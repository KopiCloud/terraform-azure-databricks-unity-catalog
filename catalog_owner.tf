# ---------------------------
# Azure Databricks UC Catalog
# ---------------------------

// Create Databricks Catalog
resource "databricks_catalog" "lab" {
  provider = databricks.workspace

  metastore_id = databricks_metastore.primary.id
  name         = "dbxlab"
  comment      = "Databricks Lab Catalog"
  owner        = databricks_group.uc_admins.display_name

  properties = {
    purpose = "lab"
  }
  
  depends_on = [databricks_metastore_assignment.primary]
}

// Assign Permissions to the Databricks Catalog (optional)
resource "databricks_grants" "lab_catalog" {
  provider = databricks.workspace
  
  catalog = databricks_catalog.lab.name

  grant {
    principal  = "Data Scientists"
    privileges = ["USE_CATALOG", "CREATE"]
  }
  
  grant {
    principal  = "Data Engineers"
    privileges = ["USE_CATALOG"]
  }
}
