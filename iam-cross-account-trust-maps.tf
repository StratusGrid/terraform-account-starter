#This is preconfigured to make the groups and policies for role assumption of roles in the same account.
#If you are doing this for across account, you will want ot change the caller_identity_curent variables out for a users account id variable.
#If you do this for multiple accounts, you should prepend/append with environment. For instance, restricted_admin -> prod_restricted_admin, restricted-admin becomes restricted-admin-prod and so forth.


module "iam_group_restricted_admin" {
  source  = "StratusGrid/iam-group-with-user-self-service/aws"
  version = "2.0.0"
  # source  = "github.com/StratusGrid/terraform-aws-iam-group-with-user-self-service"

  name = "${var.name_prefix}-restricted-admin"
}

module "iam_cross_account_trust_map_restricted_admin" {
  source  = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "2.0.1"
  #source = "github.com/StratusGrid/terraform-aws-iam-cross-account-trust-maps"

  trusting_role_arn   = module.restricted_admin.role_arn
  trusted_policy_name = module.iam_group_restricted_admin.group_name
  trusted_group_names = [
    module.iam_group_restricted_admin.group_name
  ]

  require_mfa = true
  input_tags  = merge(local.common_tags, {})
}

module "iam_group_restricted_read_only" {
  source  = "StratusGrid/iam-group-with-user-self-service/aws"
  version = "2.0.0"
  # source  = "github.com/StratusGrid/terraform-aws-iam-group-with-user-self-service"

  name = "${var.name_prefix}-restricted-read-only"
}

module "iam_cross_account_trust_map_restricted_read_only" {
  source  = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "2.0.1"
  # source = "github.com/StratusGrid/terraform-aws-iam-cross-account-trust-maps"

  trusting_role_arn   = module.restricted_read_only.role_arn
  trusted_policy_name = module.iam_group_restricted_read_only.group_name
  trusted_group_names = [
    module.iam_group_restricted_read_only.group_name
  ]

  require_mfa = true
  input_tags  = merge(local.common_tags, {})
}

