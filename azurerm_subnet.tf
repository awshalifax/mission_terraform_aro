# Create subnets

resource "azurerm_subnet" "master-subnet" {
  name                                          = "master-subnet"
  resource_group_name                           = azurerm_resource_group.openshift-cluster.name
  virtual_network_name                          = azurerm_virtual_network.virtual-network.name
  address_prefixes                              = ["10.0.0.0/23"]
  enforce_private_link_service_network_policies = true
  service_endpoints                             = ["Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "worker-subnet" {
  name                                          = "worker-subnet"
  resource_group_name                           = azurerm_resource_group.openshift-cluster.name
  virtual_network_name                          = azurerm_virtual_network.virtual-network.name
  address_prefixes                              = ["10.0.2.0/23"]
  enforce_private_link_service_network_policies = true
  service_endpoints                             = ["Microsoft.ContainerRegistry"]
}
