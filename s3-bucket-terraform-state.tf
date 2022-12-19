module "terraform_state" {
  source  = "StratusGrid/terraform-state-s3-bucket-centralized-with-roles/aws"
  version = "~> 4.0"

  name_prefix   = var.name_prefix
  name_suffix   = local.name_suffix
  log_bucket_id = module.s3_bucket_logging_us_east_1.bucket_id
  account_arns = [
  ]
  global_account_arns = []
  input_tags          = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-east-2
  }
}
