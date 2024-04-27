# Get the details from vpc state file

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    bucket = "prod-terraform-files"
    key    = "vpc/terraform.tfstate"
  }
}