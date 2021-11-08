variable "deploy" {
  description = "true = Create Cluster | False = Destroy cluster"
}

locals { #testar sem isso aqui, colocar direto nos comandos
  ms     = azurerm_subnet.master-subnet.name
  wk     = azurerm_subnet.worker-subnet.name
  rg     = azurerm_resource_group.openshift-cluster.name
  loc    = var.location
  vnet   = azurerm_virtual_network.virtual-network.name
  name   = "aro01"
  domain = azurerm_dns_zone.aro-dns-zone.name
}

#az aro create -g openshift-cluster-dev -n aro01 --vnet virtual-network-dev --master-subnet master-subnet --worker-subnet worker-subnet --domain williamopenshift.eastus.aroapp.io --location eastus --pull-secret @pull-secret
resource "null_resource" "create-cluster" {
  count = var.deploy ? 1 : 0
  provisioner "local-exec" {
    command = "az aro create -g ${local.rg} -n ${local.name} --vnet ${local.vnet} --master-subnet ${local.ms} --worker-subnet ${local.wk} --domain ${local.domain} --location ${local.loc} --pull-secret @pull-secret"
  }

  depends_on = [
    azurerm_subnet.master-subnet,
    azurerm_subnet.worker-subnet,
    azurerm_virtual_network.virtual-network,
    azurerm_dns_zone.aro-dns-zone
  ]

}

#az aro delete -n aro01 -g openshift-cluster-dev --yes
resource "null_resource" "delete-cluster" {
  count = var.deploy ? 0 : 1
  provisioner "local-exec" {
    command = "az aro delete -n ${local.name} -g ${local.rg} --yes"
  }
}