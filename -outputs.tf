output "account_id" {
  description = "Account which terraform was run on"
  value = "${data.aws_caller_identity.current.account_id}"
}

output "name_prefix" {
  description = "string to prepend to all resource names"
  value = "${var.name_prefix}"
}

output "name_suffix" {
  description = "string to append to all resource names"
  value = "${local.name_suffix}"
}

output "common_tags" {
  description = "tags which should be applied to all taggable objects"
  value = "${local.common_tags}"
}

output "terraform_state_bucket" {
  description = "s3 bucket to store terraform state"
  value = "${module.terraform_state.bucket}"
}

output "terraform_state_dynamodb_table" {
  description = "dynamodb table to control terraform locking"
  value = "${module.terraform_state.dynamodb_table}"
}

output "terraform_state_kms_key_id" {
  description = "kms key to use for encrytption when storing/reading terraform state configuration"
  value = "${module.terraform_state.kms_key_id}"
}

output "terraform_state_config_s3_key" {
  description = "key to use for terraform state key configuration - this is the s3 object key where the config will be stored"
  value = "${var.name_prefix}${local.name_suffix}.tfstate"
}