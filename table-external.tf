// Create Databricks Catalog for External Tables
resource "databricks_catalog" "external" {
  provider = databricks.workspace

  metastore_id = databricks_metastore.primary.id
  name         = "dbx_external_lab"
  comment      = "Databricks External Lab Catalog"
  owner        = databricks_group.uc_admins.display_name
  
  properties = {
    purpose = "external_lab"
  }
  
  depends_on = [databricks_metastore_assignment.primary]
}

// Create a Databrick Schema for External Tables
resource "databricks_schema" "external" {
  provider = databricks.workspace

  catalog_name = databricks_catalog.external.id
  name         = "external_architecture"
  comment      = "External Architecture Schema"
  owner        = databricks_group.uc_admins.display_name
  
  properties = {
    kind = "external documentation"
  }
}

// Create an External Table
resource "databricks_sql_table" "external" {
  provider     = databricks.workspace
  
  name               = "external_lab_table"
  catalog_name       = databricks_catalog.external.name
  schema_name        = databricks_schema.external.name
  table_type         = "EXTERNAL"
  data_source_format = "DELTA"
  storage_location   = databricks_external_location.external.url

  column {
    name = "id"
    type = "int"
  }
  column {
    name    = "name"
    type    = "string"
    comment = "name of event"
  }
  comment = "external table"
}
