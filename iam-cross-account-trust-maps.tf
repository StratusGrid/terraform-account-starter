#This is preconfigured to make the groups and policies for role assumption of roles in the same account.
#If you are doing this for across account, you will want ot change the caller_identity_curent variables out for a users account id variable.
#If you do this for multiple accounts, you should prepend/append with environment. For instance, restricted_admin -> prod_restricted_admin, restricted-admin becomes restricted-admin-prod and so forth.
locals {
  trusting_role_arn_restricted_admin = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.name_prefix}-restricted-admin-role"
  trusting_role_arn_restricted_read_only = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.name_prefix}-restricted-read-only-role"
}

resource "aws_iam_group" "restricted_admin" {
  name = "${var.name_prefix}-restricted-admin"
}


module "iam_cross_account_trust_map_restricted_admin" {
  source = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "1.1.0"
  trusting_role_arn = "${local.trusting_role_arn_restricted_admin}"
  trusted_policy_name = "${aws_iam_group.restricted_admin.name}"
  trusted_group_names = [
    "${aws_iam_group.restricted_admin.name}"
  ]
  require_mfa = true  
  input_tags = "${local.common_tags}"
}


resource "aws_iam_group" "restricted_read_only" {
  name = "${var.name_prefix}-restricted-read-only"
}

module "iam_cross_account_trust_map_restricted_read_only" {
  source = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "1.1.0"
  trusting_role_arn = "${local.trusting_role_arn_restricted_read_only}"
  trusted_policy_name = "${aws_iam_group.restricted_read_only.name}"
  trusted_group_names = [
    "${aws_iam_group.restricted_read_only.name}"
  ]
  require_mfa = true  
  input_tags = "${local.common_tags}"
}
