# ---------------------------
# Azure Databricks UC Catalog
# ---------------------------

// Create Databricks Catalogresource "databricks_catalog" "lab" {
  metastore_id = databricks_metastore.primary.id
  name         = "dbxlab"
  comment      = "Databricks Lab Catalog"
  properties = {
    purpose = "lab"
  }
  
  depends_on = [databricks_metastore_assignment.primary]
}

// Assign Permissions to the Databricks Catalog
resource "databricks_grants" "lab" {
  catalog = databricks_catalog.lab.name

  grant {
    principal  = "Unity Catalog Admins"
    privileges = ["ALL_PRIVILEGES"]
  }
  
  grant {
    principal  = "Data Scientists"
    privileges = ["USE_CATALOG", "CREATE"]
  }
  
  grant {
    principal  = "Data Engineers"
    privileges = ["USE_CATALOG"]
  }
}
