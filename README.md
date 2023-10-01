# How to Configure Azure Databricks Unity Catalog using Terraform
[![Terraform](https://img.shields.io/badge/terraform-v1.5+-blue.svg)](https://www.terraform.io/downloads.html)

Blog Part 1--> 

## Code creates:

* Deploying SQL Warehouse
* Creating the Databricks Access Connector
* Creating the Azure Storage Account for the Unity Catalog
* Creating the Azure Storage Container for the Unity Catalog
* Assigning Permissions to the Service Principal to the Storage Account
* Creating the Databricks Metastore
* Assigning the Metastore to the Workspace
* Assigning the Acess Connector to the Metastore

## How to use this code:

* Update the file **terraform.tfvars** to adjust the code to your environment

## How To deploy the code:

1. Clone the repo
2. Update variables to your environment
3. Execute "terraform init"
4. Execute "terraform apply"

## References

How to Deploy Databricks in Azure with Terraform Step by Step --> https://medium.com/@gmusumeci/how-to-deploy-databricks-in-azure-with-terraform-step-by-step-e1262e456be9
