###############################################
# AWS Provider information
################################################
provider "aws" {
  region = var.region
}

terraform {
  required_version = "1.5.7"

  required_providers {
    aws = ">= 2.54"
  }
}

################################################
# Kubernetes Provider configuration
################################################
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}