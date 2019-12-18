module "terraform_state" {
  source  = "StratusGrid/terraform-state-s3-bucket-centralized-with-roles/aws"
  version = "2.0.1"
  # source  = "github.com/StratusGrid/terraform-aws-terraform-state-s3-bucket-centralized-with-roles"
  
  name_prefix   = var.name_prefix
  name_suffix   = local.name_suffix
  log_bucket_id = module.s3_bucket_logging.bucket_id
  account_arns = [
  ]
  global_account_arns = []
  input_tags          = merge(local.common_tags, {})
}

