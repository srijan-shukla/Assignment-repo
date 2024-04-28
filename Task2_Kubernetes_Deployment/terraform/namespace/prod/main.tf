##############################################################
# AWS Provider information
##############################################################

provider "aws" {
  region = local.region
}

##############################################################
# Define Terraform state backend
##############################################################

terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "prod-terraform-files"
    key            = "eks/namespace/prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-dynamodb"
  }
}



##############################################################
# Get the details from vpc state file
##############################################################

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    bucket = "prod-terraform-files"
    key    = "eks/cluster/terraform.tfstate"
  }
}


################################################
# Provider configuration
################################################

provider "kubernetes" {
  host                   =  data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.cluster_certificate_authority_data)

  exec {
  #  api_version = "client.authentication.k8s.io/v1alpha1"
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.eks.outputs.cluster_id]
  }
}



################################################
# Namespace module
################################################


resource "kubernetes_namespace" "prod" {
  metadata {
    annotations = {
      name = "prod"
    }

    labels = {
      mylabel = "prod"
    }

    name = "prod"
  }
}