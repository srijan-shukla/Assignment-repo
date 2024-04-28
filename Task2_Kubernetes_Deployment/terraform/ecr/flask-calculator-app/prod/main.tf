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
    key            = "eks/ecr/flask-calculator-app/prod/terraform.tfstate"
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




module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "flask-calculator-app/prod"
  repository_image_scan_on_push = true
}  