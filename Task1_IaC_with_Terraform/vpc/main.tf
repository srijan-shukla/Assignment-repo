################################################
# VPC Module
################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"  # The source of the VPC module
  version = "~> 5.1.2"  # The version of the VPC module

  name = "${local.environment}-${local.name}-vpc"  # The name of the VPC
  cidr = "10.16.224.0/20"  # The CIDR block for the VPC

  azs                 = ["${local.region}a", "${local.region}b"]  # The availability zones for high availability
  private_subnets     = ["10.16.224.0/22", "10.16.228.0/22","10.16.232.0/22"]  # The CIDR blocks for the private subnets
  private_subnet_names = [ "prod-fca-vpc-ap-south-1a" , "prod-fca-vpc-ap-south-1b"]  # The names of the private subnets
  public_subnets      = ["10.16.236.0/25", "10.16.236.128/25","10.16.237.0/25"]  # The CIDR blocks for the public subnets

  manage_default_route_table = true  # Whether to manage the default route table
  default_route_table_tags   = { DefaultRouteTable = true }  # The tags for the default route table

  enable_dns_hostnames = true  # Whether to enable DNS hostnames
  enable_dns_support   = true  # Whether to enable DNS support
  enable_vpn_gateway   = true  # Whether to enable a VPN gateway
  map_public_ip_on_launch = false  # Whether to assign a public IP on launch

  private_subnet_suffix     = "app"  # The suffix for the private subnets
  public_subnet_suffix      = "public"  # The suffix for the public subnets
     
  one_nat_gateway_per_az    = true  # Whether to create one NAT gateway per availability zone
  enable_nat_gateway = true  # Whether to enable NAT gateway
  single_nat_gateway = false  # Whether to create a single NAT gateway

  enable_dhcp_options              = true  # Whether to enable DHCP options
  dhcp_options_domain_name         = "service.consul"  # The domain name for the DHCP options
  dhcp_options_domain_name_servers = ["10.16.224.2"]  # The domain name servers for the DHCP options

  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = false  # Whether to manage the default security group
  default_security_group_ingress = []  # The ingress rules for the default security group
  default_security_group_egress  = []  # The egress rules for the default security group

  public_subnet_tags = {  # The tags for the public subnets for the AWS ALB ingress controller
    "kubernetes.io/cluster/prod-fca" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {  # The tags for the private subnets the AWS ALB ingress controller
    "kubernetes.io/cluster/prod-fca" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = local.tags  # The tags for the VPC
}
