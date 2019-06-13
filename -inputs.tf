variable "account_numbers" {
  type = "list"
  default = []
}

variable "region" {
  description = "AWS Region to target"
  type = "string"
}

variable "access_key" {
  description = "AWS access key"
  type = "string"
  default = ""
}

variable "secret_key" {
  description = "AWS secret key"
  type = "string"
  default = ""
}

variable "token" {
  description = "MFA Token retrieved with sts get-session-token"
  type = "string"
  default = ""
}

variable "name_prefix" {
  description = "String to use as prefix on object names"
  type = "string"
}

variable "name_suffix" {
  description = "String to append on object names"
  type = "string"
  default = ""
}

variable "env_name" {
  description = "Environment name string to be used for decisions and name generation"
  type = "string"
  default = ""
}
