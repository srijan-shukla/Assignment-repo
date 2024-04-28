
################################################
# Tags variables defined into locals
################################################

locals {
  region       = var.region
  environment  = var.environment
  component   = var.component
  cluster_name = var.cluster_name
  clluster_version = var.cluster_version
  key_name = var.key_name
  tags         = var.tags
}

