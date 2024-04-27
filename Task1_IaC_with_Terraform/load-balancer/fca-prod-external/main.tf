################################################
# ALB Module
################################################

module "fca-prod-app-alb-external" {
  source             = "terraform-aws-modules/alb/aws"  # The source of the ALB module
  version            = "9.4.1"  # The version of the ALB module

  name               = "${local.environment}-${local.name}-common-app-alb-external"  # The name of the ALB
  internal           = false  # Whether the load balancer is internal or external
  load_balancer_type = local.load_balancer_type  # The type of load balancer to create

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id  # The ID of the VPC in which to create the load balancer
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnets  # A list of subnet IDs to attach to the load balancer
  security_groups    = [data.terraform_remote_state.security_groups.outputs.fca_sg_common_security_group_id]  # A list of security group IDs to assign to the load balancer

  tags = local.tags  # The tags to assign to the load balancer
}