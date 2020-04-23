output "account_id" {
  description = "Account which terraform was run on"
  value       = data.aws_caller_identity.current.account_id
}

output "name_prefix" {
  description = "string to prepend to all resource names"
  value       = var.name_prefix
}

output "name_suffix" {
  description = "string to append to all resource names"
  value       = local.name_suffix
}

output "common_tags" {
  description = "tags which should be applied to all taggable objects"
  value       = local.common_tags
}

output "log_bucket_ids" {
  description = "ID of logging bucket"
  value       = [
  module.s3_bucket_logging_us_east_1.bucket_id,
  module.s3_bucket_logging_us_east_2.bucket_id,
  module.s3_bucket_logging_us_west_1.bucket_id,
  module.s3_bucket_logging_us_west_2.bucket_id
  ]
}

output "terraform_state_bucket" {
  description = "s3 bucket to store terraform state"
  value       = module.terraform_state.bucket
}

output "terraform_state_dynamodb_table" {
  description = "dynamodb table to control terraform locking"
  value       = module.terraform_state.dynamodb_table
}

output "terraform_state_kms_key_arn" {
  description = "kms key to use for encrytption when storing/reading terraform state configuration"
  value       = module.terraform_state.kms_default_key_arn
}

output "terraform_state_config_s3_key" {
  description = "key to use for terraform state key configuration - this is the s3 object key where the config will be stored"
  value       = "${var.name_prefix}-account${local.name_suffix}.tfstate"
}

output "iam_role_url_restricted_admin" {
  description = "URL to assume restricted admin role in this account"
  value       = module.restricted_admin.role_assumption_url
}

output "iam_role_url_restricted_read_only" {
  description = "URL to assume restricted read only role in this account"
  value       = module.restricted_read_only.role_assumption_url
}

