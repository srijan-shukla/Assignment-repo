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

variable "tags" {
  description = "Common tags to attach to all resources"
  type        = map(string)
  default = {
    Terraform   = "True"
    environment = "prod"
  }
}

variable "load_balancer_type"" {
  description = "The type of load balancer to create. Possible values are application or network"
  default     = "application"
}