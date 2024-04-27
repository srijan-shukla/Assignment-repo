variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "fca"
}

variable "region" {
  description = "The region where AWS operations will take place"
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment where the infrastructure is being built"
  default     = "prod"
}

variable "ami" {
  description = "The AMI to use for the instance"
  default     = "ami-1ecegf9c1e8238ce1"
}

variable "instance_type" {
  description = "The type of instance to start"
  default     = "m6g.large"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = "prod-fca"
}

variable "tags" {
  description = "Common tags to attach to all resources"
  type        = map(string)
  default = {
    Terraform   = "True"
    environment = "prod"
  }
}