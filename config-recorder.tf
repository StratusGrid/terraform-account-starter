module "aws_config_recorder_us_east_1" {
  # source = "../StratusGrid/terraform-aws-config-recorder"
  source = "StratusGrid/config-recorder/aws"
  version = "1.0.0"
  log_bucket_id = "${module.s3_bucket_logging.bucket_id}"
  providers = {
    aws = "aws.us-east-1"
  }
}

module "aws_config_recorder_us_east_2" {
  # source = "../StratusGrid/terraform-aws-config-recorder"
  source = "StratusGrid/config-recorder/aws"
  version = "1.0.0"
  log_bucket_id = "${module.s3_bucket_logging.bucket_id}"
  providers = {
    aws = "aws.us-east-2"
  }
}

module "aws_config_recorder_us_west_1" {
  # source = "../StratusGrid/terraform-aws-config-recorder"
  source = "StratusGrid/config-recorder/aws"
  version = "1.0.0"
  log_bucket_id = "${module.s3_bucket_logging.bucket_id}"
  providers = {
    aws = "aws.us-west-1"
  }
}

module "aws_config_recorder_us_west_2" {
  # source = "../StratusGrid/terraform-aws-config-recorder"
  source = "StratusGrid/config-recorder/aws"
  version = "1.0.0"
  log_bucket_id = "${module.s3_bucket_logging.bucket_id}"
  providers = {
    aws = "aws.us-west-2"
  }
}
