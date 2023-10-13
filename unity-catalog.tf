# --------------------------------------
# Azure Databricks Unity Catalog Storage
# --------------------------------------

// Create Databricks Access Connector for Unity Catalog
resource "azurerm_databricks_access_connector" "unity" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-databricks-unity-mi"
  location            = var.location
  resource_group_name = var.databricks_workspace_rg

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

// Create Azure Storage Account for Unity Catalog
resource "azurerm_storage_account" "unity_catalog" {
  name                     = "${lower(replace(var.company," ","-"))}${var.app_name}${var.environment}${var.shortlocation}unityst"
  location                 = var.location
  resource_group_name      = var.databricks_workspace_rg
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true

  tags = local.tags
}

// Create Azure Storage Container for Unity Catalog
resource "azurerm_storage_container" "unity_catalog" {
  name                  = "unity-catalog-container"
  storage_account_name  = azurerm_storage_account.unity_catalog.name
  container_access_type = "private"
}

// Assign Access to the Service Principal to the Storage Account
resource "azurerm_role_assignment" "unity_catalog" {
  scope                = azurerm_storage_account.unity_catalog.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.unity.identity[0].principal_id
}
