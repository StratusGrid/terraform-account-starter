module "s3_bucket_logging_us_east_1" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "~> 2.0"

  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-1"
  input_tags  = merge() # This is blank for module compatibility, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-east-1
  }

  # Uncomment the below if you wish to enable centralized logging to S3
  /* enable_centralized_logging = true
  s3_destination_bucket_name = var.s3_destination_bucket_name
  iam_role_s3_replication_arn = module.iam_role_s3[0].iam_role_arn
  logging_account_id = var.logging_account_id */
}

module "s3_bucket_logging_us_east_2" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "~> 2.0"

  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-2"
  input_tags  = merge() # This is blank for module compatibility, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-east-2
  }

  # Uncomment the below if you wish to enable centralized logging to S3
  /* enable_centralized_logging = true
  s3_destination_bucket_name = var.s3_destination_bucket_name
  iam_role_s3_replication_arn = module.iam_role_s3[0].iam_role_arn
  logging_account_id = var.logging_account_id */
}

module "s3_bucket_logging_us_west_1" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "~> 2.0"

  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-west-1"
  input_tags  = merge() # This is blank for module compatibility, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-west-1
  }

  # Uncomment the below if you wish to enable centralized logging to S3
  /* enable_centralized_logging = true
  s3_destination_bucket_name = var.s3_destination_bucket_name
  iam_role_s3_replication_arn = module.iam_role_s3[0].iam_role_arn
  logging_account_id = var.logging_account_id */
}

module "s3_bucket_logging_us_west_2" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "~> 2.0"

  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-west-2"
  input_tags  = merge() # This is blank for module compatibility, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-west-2
  }

  # Uncomment the below if you wish to enable centralized logging to S3
  /* enable_centralized_logging = true
  s3_destination_bucket_name = var.s3_destination_bucket_name
  iam_role_s3_replication_arn = module.iam_role_s3[0].iam_role_arn
  logging_account_id = var.logging_account_id */
}