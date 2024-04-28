################################################
# Get the details from vpc state file
################################################

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    bucket = "prod-terraform-files"
    key    = "vpc/terraform.tfstate"
  }
}

################################################
# Get the details of latest eks optimized ami by AWS SSM Parameter
################################################
data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/1.28/amazon-linux-2-arm64/recommended/image_id"
}


# aws_caller_identity to get the account details
data "aws_caller_identity" "current" {}