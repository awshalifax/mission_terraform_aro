variable "deploy" {
  description = "true = Create Cluster | false = Destroy cluster"
}

locals { #testar sem isso aqui, colocar direto nos comandos
  ms     = "master-sub"
  wk     = "worker-sub"
  rg     = azurerm_resource_group.openshift-cluster.name
  loc    = var.location
  vnet   = module.arovnet.vnet_name
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
    azurerm_dns_zone.aro-dns-zone,
    azurerm_resource_group.openshift-cluster,
    module.arovnet

  ]

}

#az aro delete -n aro01 -g openshift-cluster-dev --yes
resource "null_resource" "delete" {
  count = var.deploy ? 0 : 1
  provisioner "local-exec" {
    command = "az aro delete -n ${local.name} -g ${local.rg} --yes"
  }
}



