# Tags variables defined into locals
locals {
  name         = var.name
  region       = var.region
  environment  = var.environment
  ami          = var.ami
  instance_type= var.instance_type
  key_name     = var.key_name
  tags         = var.tags
}