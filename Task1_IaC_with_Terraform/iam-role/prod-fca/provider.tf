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