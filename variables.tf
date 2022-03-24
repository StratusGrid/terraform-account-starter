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

variable "monthly_billing_threshold" {
  description = "The maximum amount that can be billed after which a cloudwatch alarm triggers"
  type = string
  default     = "10000"
}

variable "currency" {
  description = "This defines the currency in the monthly_billing_threshold"
  type = string
  default     = "USD"
}
