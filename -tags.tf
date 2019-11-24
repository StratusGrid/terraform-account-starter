locals {
  common_tags = {
    Environment = var.env_name
    SourceRepo  = var.source_repo
    Developer   = "ChrisHurst"
    Provisioner = "Terraform"
    Terraform   = "true"
  }
}

