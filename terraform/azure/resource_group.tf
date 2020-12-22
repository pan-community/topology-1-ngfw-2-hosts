resource "azurerm_resource_group" "resourcegroup" {
  name = var.resource_group_name
  location = var.Azure_Region
}