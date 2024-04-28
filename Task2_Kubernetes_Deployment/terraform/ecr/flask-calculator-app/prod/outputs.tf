output "ecr_repository_name" { 
  description = "ECR repository URL" 
  value = module.ecr.repository_name
}
output "ecr_repository_url" { 
  description = "ECR repository URL" 
  value = module.ecr.repository_url 
}