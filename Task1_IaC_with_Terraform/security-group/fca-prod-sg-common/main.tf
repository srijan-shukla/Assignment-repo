
################################################
# Security Group Module
################################################

module "fca_sg_common" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-${local.environment}-sg-common"
  description = "${local.name}-${local.environment} common security group"
  vpc_id      =  data.terraform_remote_state.vpc.outputs.vpc_id

 ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "allow ssh from new office subnets"
      cidr_blocks = "10.16.224.0/20"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "allow 443 for office ips"
      cidr_blocks = "10.16.224.0/20"
    }
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "allow 443 for office ips"
      cidr_blocks = "10.16.224.0/20"
    }

]

  egress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "allow https outbound requests"
      cidr_blocks = "10.16.224.0/20"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "allow http outbound requests"
      cidr_blocks = "10.16.224.0/20"
    }
]

}
