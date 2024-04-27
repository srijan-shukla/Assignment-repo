output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.iam_assumable_role.iam_role_arn, "")
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = try(module.iam_assumable_role.iam_role_name, "")
}


output "iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = try(module.iam_assumable_role.iam_instance_profile_name, "")
}