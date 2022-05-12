locals {
  common_tags = {
    Environment = var.env_name
    SourceRepo  = var.source_repo
    Developer   = "StratusGrid"
    Provisioner = "Terraform"
    Terraform   = "true"
  }
}
