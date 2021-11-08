resource "azurerm_dns_zone" "aro-dns-zone" {
  name                = "williamopenshift.eastus.aroapp.io"
  resource_group_name = azurerm_resource_group.openshift-cluster.name
}