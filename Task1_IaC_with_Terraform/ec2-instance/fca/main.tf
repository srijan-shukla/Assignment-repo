################################################
# EC2 Module
################################################

module "fca_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"  # The source of the EC2 module
  version = "3.0"  # The version of the EC2 module

  name = "${local.name}-${local.environment}"  # The name of the EC2 instance

  ami                     = local.ami  # The Amazon Machine Image (AMI) ID of the instance
  instance_type           = local.instance_type  # The type of instance to launch
  key_name                = local.key_name  # The key pair name to use for the instance
  monitoring              = true  # Whether to enable detailed monitoring
  vpc_security_group_ids  = [data.terraform_remote_state.security_groups.outputs.fca_sg_common_security_group_id]  # The security group IDs to assign to the instance
  subnet_id               = data.terraform_remote_state.vpc.outputs.app_subnets[0]  # The ID of the subnet to launch the instance into
  disable_api_termination = false  # Whether to enable termination protection
  iam_instance_profile   = "prod-fca"  # The IAM Instance Profile to associate with the instance

  ebs_block_device = [{  # Additional EBS block devices to attach to the instance
    volume_type = "gp3"  # The type of volume
    device_name = "/dev/sdf"  # The name of the device within the instance
    volume_size = 20  # The size of the volume in gibibytes (GiB)
  }]

  tags = local.tags  # The tags to assign to the instance
}