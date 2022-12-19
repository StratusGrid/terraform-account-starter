module "cloudtrail" {
  count = var.control_tower_enabled == false ? 1 : 0

  #ts:skip=AC_AWS_0207 SG_Sub_Module
  source  = "StratusGrid/cloudtrail/aws"
  version = "~> 3.0"

  name_prefix = var.name_prefix
  name_suffix = local.name_suffix
  log_bucket  = module.s3_bucket_logging_us_east_2.bucket_id
  input_tags  = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
  providers = {
    aws = aws.us-east-2
  }
}
