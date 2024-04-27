output "fca_ec2_instance_id" {
  description = "The ID of the instance"
  value       = module.fca_ec2_instance.id
}

output "fca_ec2_instance_arn" {
  description = "The ARN of the instance"
  value       = module.fca_ec2_instance.arn
}