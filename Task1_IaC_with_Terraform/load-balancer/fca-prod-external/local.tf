
################################################
# Tags variables defined into locals
################################################

locals {
  name         = var.name
  region       = var.region
  environment  = var.environment
  load_balancer_type = var.load_balancer_type
  tags         = var.tags
}

