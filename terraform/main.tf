# Configure the Azure Provider
provider "azurerm" {
  features {}

  # Replace with your subscription ID
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Create a Resource Group
resource "azurerm_resource_group" "test" {
  name     = "test-resource-group"
  location = "East US"
}

output "resource_group_name" {
  value = azurerm_resource_group.test.name
}
