variable "workspace_to_environment_map" {
  type = map
  default = {
    default = "dev"
    nonprod = "stg"
    prod    = "prod"
  }
}

#Cluster related configuration
variable "location" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "eastus"
}

variable "vnet_cidr" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "10.0.0.0/22"
}

variable "master_cidr" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "10.0.0.0/23"
}

variable "worker_cidr" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "10.0.2.0/23"
}

variable "vnet_name" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "openshift-aro-vnet"
}

variable "master_subnet_name" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "master-subnet"
}

variable "worker_subnet_name" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "worker-subnet"
}

variable "openshift_cluster_name" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "openshift-cluster"
}