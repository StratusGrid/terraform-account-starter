module "s3_bucket_logging_us_east_1" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "1.1.0"
  name = "${var.name_prefix}-logging-us-east-1${local.name_suffix}"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-1
  }
}

module "s3_bucket_logging_us_east_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "1.1.0"
  name = "${var.name_prefix}-logging-us-east-2${local.name_suffix}"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-2
  }
}

module "s3_bucket_logging_us_west_1" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "1.1.0"
  name = "${var.name_prefix}-logging-us-west-1${local.name_suffix}"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-west-1
  }
}

module "s3_bucket_logging_us_west_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "1.1.0"
  name = "${var.name_prefix}-logging-us-west-2${local.name_suffix}"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-west-2
  }
}