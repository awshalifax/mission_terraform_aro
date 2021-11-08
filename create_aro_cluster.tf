variable "deploy" {
  description = "true = Create Cluster | false = Destroy cluster"
}

locals {
  ms        = var.master_subnet_name
  ms-cidr   = var.master_cidr
  wk        = var.worker_subnet_name
  wk-cidr   = var.worker_cidr
  rg        = azurerm_resource_group.openshift-cluster.name
  loc       = var.location
  vnet      = var.vnet_name
  vnet-cidr = var.vnet_cidr
  name      = var.openshift_cluster_name
  domain    = azurerm_dns_zone.aro-dns-zone.name
}

resource "null_resource" "create-vnet" {
  count = var.deploy ? 1 : 0
  provisioner "local-exec" {
    command = "az network vnet create --resource-group ${local.rg} --name ${local.vnet} --address-prefixes ${local.vnet-cidr}"
  }

  depends_on = [
    azurerm_dns_zone.aro-dns-zone,
    azurerm_resource_group.openshift-cluster
  ]
}

resource "null_resource" "create-master-subnet" {
  count = var.deploy ? 1 : 0
  provisioner "local-exec" {
    command = "az network vnet subnet create --resource-group ${local.rg} --vnet-name ${local.vnet} --name ${local.ms} --address-prefixes ${local.ms-cidr} --service-endpoints Microsoft.ContainerRegistry --disable-private-link-service-network-policies true"
  }

  depends_on = [
    null_resource.create-vnet
  ]
}

resource "null_resource" "create-worker-subnet" {
  count = var.deploy ? 1 : 0
  provisioner "local-exec" {
    command = "az network vnet subnet create --resource-group ${local.rg} --vnet-name ${local.vnet} --name ${local.wk} --address-prefixes ${local.wk-cidr} --service-endpoints Microsoft.ContainerRegistry --disable-private-link-service-network-policies true"
  }

  depends_on = [
    null_resource.create-master-subnet
  ]
}

resource "null_resource" "create-aro-cluster" {
  count = var.deploy ? 1 : 0
  provisioner "local-exec" {
    command = "az aro create -g ${local.rg} -n ${local.name} --vnet ${local.vnet} --master-subnet ${local.ms} --worker-subnet ${local.wk} --domain ${local.domain} --location ${local.loc} --pull-secret @pull-secret"
  }

  depends_on = [
    null_resource.create-worker-subnet
  ]
}

resource "null_resource" "delete-aro-cluster" {
  count = var.deploy ? 0 : 1
  provisioner "local-exec" {
    command = "az aro delete -n ${local.name} -g ${local.rg} --yes"
  }
}



