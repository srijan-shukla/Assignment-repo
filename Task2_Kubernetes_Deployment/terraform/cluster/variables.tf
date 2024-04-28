variable "region" {
  description = "The region where AWS operations will take place"
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment where the infrastructure is being built"
  default     = "prod"
}

variable "tags" {
  description = "Common tags to attach to all resources"
  type        = map(string)
  default = {
    Terraform   = "True"
    environment = "prod"
  }
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}