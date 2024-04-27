################################################
# Get the details from vpc state file
################################################

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    bucket = "prod-ppsl-mo-terraform"
    key    = "stacks/aws/aws-ppslmo-prod/ap-south-1/OE/common/prod/vpc/terraform.tfstate"
  }
}


################################################
# Get the details from sg state file
################################################

data "terraform_remote_state" "security_groups" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    bucket = "prod-terraform-files"
    key    = "security-group/fca-prod-sg-common/terraform.tfstate"
  }
}