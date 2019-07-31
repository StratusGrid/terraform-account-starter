locals {
  common_tags = {
    Environment = var.env_name
    Developer   = "ChrisHurst"
    Provisioner = "Terraform"
    Terraform   = "true"
  }
}

