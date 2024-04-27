variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`"
  type        = bool
  default     = true
}


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
