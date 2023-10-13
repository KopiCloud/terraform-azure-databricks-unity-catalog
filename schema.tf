# --------------------------
# Azure Databricks UC Schema
# --------------------------

// Create a Databrick Schema
resource "databricks_schema" "architecture" {
  provider = databricks.workspace

  catalog_name = databricks_catalog.lab.id
  name         = "architecture"
  comment      = "Architecture Schema"
  
  properties = {
    kind = "documentation"
  }
}

// Assign Permissions to the Databricks Schema
resource "databricks_grants" "architecture" {
  provider = databricks.workspace

  schema = databricks_schema.architecture.id

  grant {
    principal  = "Unity Catalog Admins"
    privileges = ["ALL_PRIVILEGES"]
  }
  
  grant {
    principal  = "Data Scientists"
    privileges = ["USE_SCHEMA", "CREATE"]
  }

  grant {
    principal  = "Data Engineers"
    privileges = ["USE_SCHEMA"]
  }
}
