module "s3_bucket_logging_us_east_1" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-1"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-1
  }
}

module "s3_bucket_logging_us_east_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-2"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-2
  }
}

module "s3_bucket_logging_us_west_1" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-west-1"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-west-1
  }
}

module "s3_bucket_logging_us_west_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-west-2"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-west-2
  }
}