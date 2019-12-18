module "aws_config_recorder_us_east_1" {
  source                        = "StratusGrid/config-recorder/aws"
  version                       = "1.0.2"
  log_bucket_id                 = module.s3_bucket_logging.bucket_id
  include_global_resource_types = true #only include global resource on one region to prevent duplicate recording of events
  providers = {
    aws = aws.us-east-1
  }
}

module "aws_config_recorder_us_east_2" {
  source        = "StratusGrid/config-recorder/aws"
  version       = "1.0.2"
  log_bucket_id = module.s3_bucket_logging.bucket_id
  providers = {
    aws = aws.us-east-2
  }
}

module "aws_config_recorder_us_west_1" {
  source        = "StratusGrid/config-recorder/aws"
  version       = "1.0.2"
  log_bucket_id = module.s3_bucket_logging.bucket_id
  providers = {
    aws = aws.us-west-1
  }
}

module "aws_config_recorder_us_west_2" {
  source        = "StratusGrid/config-recorder/aws"
  version       = "1.0.2"
  log_bucket_id = module.s3_bucket_logging.bucket_id
  providers = {
    aws = aws.us-west-2
  }
}

