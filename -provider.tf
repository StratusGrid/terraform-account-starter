provider "aws" {
  allowed_account_ids = "${var.account_numbers}"
  region              = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token      = "${var.token}"
}

#Extra Providers for Config and other Multi-Region configurations like AWS Config
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}
