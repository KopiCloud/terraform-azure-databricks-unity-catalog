# ------------------------------
# Azure Databricks SQL Warehouse
# ------------------------------

// Configures the security policy, databricks_instance_profile, and data access properties for all SQL Warehouse
resource "databricks_sql_global_config" "this" {
  data_access_config        = {}
  enable_serverless_compute = true
}

// Create SQL Warehouse
resource "databricks_sql_endpoint" "this" {
  name             = "Standard"
  cluster_size     = "2X-Small"
  min_num_clusters = 1
  max_num_clusters = 1
  auto_stop_mins   = 10
  warehouse_type   = "PRO"
  
  enable_serverless_compute = true

  depends_on = [databricks_sql_global_config.this]
}