locals {
  common_tags = {
    Environment = "${var.env_name}"
    Developer   = "StratusGrid"
    Provisioner = "Terraform"
    Terraform  = "true"
  }
}
