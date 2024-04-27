################################################
# Define Terraform state backend
################################################

terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "prod-terraform-files"
    key            = "load-balancer/fca-prod-external/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-dynamodb"
  }
}