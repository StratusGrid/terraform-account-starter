module "terraform_state" {
  source  = "StratusGrid/terraform-state-s3-bucket-centralized-with-roles/aws"
  version = "2.1.0"

  name_prefix   = var.name_prefix
  name_suffix   = local.name_suffix
  log_bucket_id = module.s3_bucket_logging_us_east_1.bucket_id
  account_arns = [
  ]
  global_account_arns = []
  input_tags          = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-1
  }
}
