module "s3_bucket_logging" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "1.0.2"
  name_prefix = var.name_prefix
  name_suffix = local.name_suffix
  input_tags  = merge(local.common_tags, {})
}

