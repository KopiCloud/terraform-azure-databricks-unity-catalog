# -----------------
# Databricks Output
# -----------------

output "unity_connector_name" {
  value = azurerm_databricks_access_connector.unity.name
}

output "unity_connector_id" {
  value = azurerm_databricks_access_connector.unity.id
}

output "unity_storage_account_name" {
  value = azurerm_storage_account.unity_catalog.name
}

output "unity_storage_container_name" {
  value = azurerm_storage_container.unity_catalog.name
}

output "metastore_path" {
  value = format("abfss://%s@%s.dfs.core.windows.net/", azurerm_storage_container.unity_catalog.name, azurerm_storage_account.unity_catalog.name)
}

output "sql_warehouse_name" {
  value = databricks_sql_endpoint.this.name
}

output "sql_warehouse_serverless_compute_enabled" {
  value = databricks_sql_endpoint.this.enable_serverless_compute
}
