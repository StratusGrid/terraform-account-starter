provider "aws" {
  allowed_account_ids = "${var.account_numbers}"
  region              = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token      = "${var.token}"
  profile    = "${var.aws_profile}"
}

#Extra Providers for Config and other Multi-Region configurations like AWS Config
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
  allowed_account_ids = "${var.account_numbers}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token      = "${var.token}"
  profile    = "${var.aws_profile}"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
  allowed_account_ids = "${var.account_numbers}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token      = "${var.token}"
  profile    = "${var.aws_profile}"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
  allowed_account_ids = "${var.account_numbers}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token      = "${var.token}"
  profile    = "${var.aws_profile}"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
  allowed_account_ids = "${var.account_numbers}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token      = "${var.token}"
  profile    = "${var.aws_profile}"
}
