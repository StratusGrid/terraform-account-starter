module "cloudtrail" {
  source  = "StratusGrid/cloudtrail/aws"
  version = "2.1.1"
  # source      = "github.com/StratusGrid/terraform-aws-cloudtrail"

  name_prefix = var.name_prefix
  name_suffix = local.name_suffix
  log_bucket  = module.s3_bucket_logging.bucket_id
  input_tags  = merge(local.common_tags, {})
}

