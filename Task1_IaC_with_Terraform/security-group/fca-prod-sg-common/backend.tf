################################################
# Define Terraform state backend
################################################

terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "prod-terraform-files"
    key            = "security-group/fca-prod-sg-common/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-dynamodb"
  }
}