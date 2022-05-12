variable "region" {
  description = "AWS Region to target"
  type        = string
}

variable "name_prefix" {
  description = "String to use as prefix on object names"
  type        = string
}

variable "prepend_name_suffix" {
  description = "String to prepend to the name_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-mysuffix-env"
  type        = string
  default     = ""
}

variable "append_name_suffix" {
  description = "String to append to the name_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-env-mysuffix"
  type        = string
  default     = ""
}

variable "override_name_suffix" {
  description = "String to completely override the name_suffix"
  type        = string
  default     = ""
}

variable "env_name" {
  description = "Environment name string to be used for decisions and name generation. Appended to name_suffix to create full_suffix"
  type        = string
}

variable "source_repo" {
  description = "URL of the repo which holds this code"
  type        = string
}

variable "trusted_users_account_arns" {
  description = "Account which users are provisioned in and should be granted access to cross account roles. Enter like arn:aws:iam::123456789012:root"
  type        = list(string)
  default     = []
}

variable "control_tower_enabled" {
  description = "A boolean true/false for if Control Tower is deployed or will be deployed. By default this is true, and setting to true removes functions that are imcompatible with Control Tower defaults/common guardrails"
  type        = bool
  default     = true
}

variable "aws_sso_enabled" {
  description = "A boolean true/false for if Control Tower is deployed or will be deployed. By default this is true, and setting to true removes functions that are replaced by AWS SSO"
  type        = bool
  default     = true
}

variable "cost_anomaly_billing_threshold" {
  description = "The amount over the normal billing threshold before alerting"
  type        = string
  default     = "50"
}

variable "payer_account" {
  description = "A boolean true/false for if this is the payer, as this will control billing alerts"
  type        = string
  default     = false
}

variable "cost_anomaly_subscription_email" {
  description = "The subscription email for AWS Cost Anomly Billing Alerts"
  type        = string
}

variable "service_limit_email" {
  description = "The subscription email for AWS Service Limits"
  type        = string
}

variable "enable_centralized_logging" {
  description = "A boolean true/false to enable centralized logging to a log archive account"
  type        = bool
}

variable "log_archive_account" {
  # tflint-ignore: terraform_unused_declarations
  description = "A boolean true/false for is this is the log archive account in the AWS Organization, as this will control centralized logging"
  # tflint-ignore: terraform_unused_declarations
  type = bool
}

variable "log_archive_retention" {
  description = "How many days to delete centralized logs"
  type        = number
  default     = 365
}

variable "aws_org_id" {
  description = "AWS Org ID"
  type        = string
}

variable "s3_destination_bucket_name" {
  description = "Destination Bucket Name for S3 Centralized Logging Replication"
  type        = string
  default     = ""
}

# tflint-ignore: terraform_unused_declarations
variable "logging_account_id" {
  description = "Centralized Logging Account ID, This will only ever be used when enabling centralized logging"
  type        = string
}