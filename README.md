# How to Configure Azure Databricks Unity Catalog using Terraform
[![Terraform](https://img.shields.io/badge/terraform-v1.5+-blue.svg)](https://www.terraform.io/downloads.html)

Blog Part 1--> https://gmusumeci.medium.com/how-to-configure-azure-databricks-unity-catalog-with-terraform-part-1-74be88c1c2d7

## Code creates:

* Deploying SQL Warehouse
* Creating the Databricks Access Connector for the Unity Catalog
* Creating the Azure Storage Account for the Unity Catalog
* Creating the Azure Storage Container for the Unity Catalog
* Assigning Permissions to the Service Principal to the Storage Account
* Creating the Databricks Metastore
* Assigning the Metastore to the Workspace
* Assigning the Access Connector to the Metastore

Blog Part 2 --> https://gmusumeci.medium.com/how-to-configure-azure-databricks-unity-catalog-with-terraform-part-2-15e780514724

* Managing Databricks Groups
* Creating Azure Databricks Unity Catalog Account Groups
* Creating Azure Databricks Workspace Groups
* Creating Unity Catalog Objects in the Metastore
* Creating a Databricks Catalog
* Creating a Databricks Catalog with a Group Owner
* Creating a Databricks Schema
* Creating a Databricks Schema with a Group Owner

## How to use this code:

* Update the file **terraform.tfvars** to adjust the code to your environment

## How To deploy the code:

1. Clone the repo
2. Update variables to your environment
3. Execute "terraform init"
4. Execute "terraform apply"

## References

How to Deploy Databricks in Azure with Terraform Step by Step --> https://medium.com/@gmusumeci/how-to-deploy-databricks-in-azure-with-terraform-step-by-step-e1262e456be9
