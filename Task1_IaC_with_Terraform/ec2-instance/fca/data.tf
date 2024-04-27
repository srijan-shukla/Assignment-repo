# Get the details from vpc state file
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-south-1"
    bucket = "prod-terraform-files"
    key    = "vpc/terraform.tfstate"
  }
}

# Get the details from sg state file
data "terraform_remote_state" "security_groups" {
  backend = "s3"
  config = {
    region = "ap-south-1"
    bucket = "prod-terraform-files"
    key    = "security-group/fca-prod-sg-common/terraform.tfstate"
  }
}