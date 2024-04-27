################################################
# IAM Role Module
################################################

module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"  # The source of the IAM module
  version = "v4.0.0"  # The version of the IAM module

  trusted_role_services = [
    "ec2.amazonaws.com"  # The service that is allowed to assume this role
  ]
  create_role = true  # Whether to create the role

  role_name         = local.name  # The name of the role
  role_requires_mfa = false  # Whether the role requires MFA to assume

  custom_role_policy_arns = [  # The ARNs of the policies to attach to the role for connecting wiith EKS NODE
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]
  number_of_custom_role_policy_arns = 1  # The number of custom role policy ARNs
  tags                              = local.tags  # The tags to assign to the role
}

################################################
# IAM Instance Profile
################################################

resource "aws_iam_instance_profile" "main" {
  name = local.name  # The name of the instance profile
  path = "/"  # The path in which to create the instance profile
  role = module.iam_assumable_role.iam_role_name  # The name of the role to associate with the instance profile
  tags = local.tags  # The tags to assign to the instance profile
}