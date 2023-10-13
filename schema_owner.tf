# --------------------------
# Azure Databricks UC Schema
# --------------------------

// Create a Databrick Schema
resource "databricks_schema" "architecture" {
  provider = databricks.workspace

  catalog_name = databricks_catalog.lab.id
  name         = "architecture"
  comment      = "Architecture Schema"
  owner        = databricks_group.uc_admins.display_name
  
  properties = {
    kind = "documentation"
  }
}

// Assign Permissions to the Databricks Schema (Optional)
resource "databricks_grants" "architecture" {
  provider = databricks.workspace

  schema = databricks_schema.architecture.id

  grant {
    principal  = "Data Scientists"
    privileges = ["USE_SCHEMA", "CREATE"]
  }

  grant {
    principal  = "Data Engineers"
    privileges = ["USE_SCHEMA"]
  }
}
