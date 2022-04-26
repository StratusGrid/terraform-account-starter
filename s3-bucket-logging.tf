module "s3_bucket_logging_us_east_1" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-1"
  input_tags  = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-east-1
  }
}

module "s3_bucket_logging_us_east_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-2"
  input_tags  = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-east-2
  }
}

module "s3_bucket_logging_us_west_1" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-west-1"
  input_tags  = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-west-1
  }
}

module "s3_bucket_logging_us_west_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "~> 1.4.0"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-west-2"
  input_tags  = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-west-2
  }
}