# Input variables are parameters for Terraform modules

variable "workspace_to_environment_map" {
  type = map
  default = {
    default = "dev"
    nonprod = "stg"
    prod    = "prod"
  }
}

variable "location" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "eastus"
}
