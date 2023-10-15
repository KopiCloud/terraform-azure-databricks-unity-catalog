// Create Databricks Access Connector for External Storage Accounts
resource "azurerm_databricks_access_connector" "external" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-databricks-ext-mi"
  location            = var.location
  resource_group_name = var.databricks_workspace_rg

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

// Configure Authentication Methods to Access Cloud Storage 
resource "databricks_storage_credential" "external" {
  name = azurerm_databricks_access_connector.external.name
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.external.id
  }
  owner   = databricks_group.uc_admins.display_name
  comment = "External Storage Account"
}

// Deploy External Storage Accounts
resource "azurerm_storage_account" "external" {
  name                     = "${lower(replace(var.company," ","-"))}${var.app_name}${var.environment}${var.shortlocation}extst"
  location                 = var.location
  resource_group_name      = var.databricks_workspace_rg
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

// Create Azure Storage Container for External Storage Account
resource "azurerm_storage_container" "external" {
  provider = azurerm.databricks

  name                  = "kopicloud-container"
  storage_account_name  = module.storage_account_external.name
  container_access_type = "private"

  depends_on = [ module.storage_account_external ]
}

// Assign Access to the Service Principal to the Storage Account
resource "azurerm_role_assignment" "external" {
  provider = azurerm.databricks

  scope                = module.storage_account_external.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.external.identity[0].principal_id

  depends_on = [ module.storage_account_external, azurerm_storage_container.external ]
}

// Create External Location
resource "databricks_external_location" "external" {
  provider = databricks.workspace  

  name = "kopicloud-external-location"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    azurerm_storage_container.external.name,
    module.storage_account_external.name)

  credential_name = databricks_storage_credential.external.id
  owner           = databricks_group.uc_admins.display_name
  comment         = "External Location"
}

// Assign Permissions to the External Location
resource "databricks_grants" "external_location" {
  provider = databricks.workspace
  
  external_location = databricks_external_location.external.id

  grant {
    principal  = "Data Engineers"
    privileges = ["CREATE_TABLE", "READ_FILES"]
  }
}
