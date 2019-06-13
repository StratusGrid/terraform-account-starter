provider "aws" {
  allowed_account_ids = "${var.account_numbers}"
  region              = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token      = "${var.token}"
}