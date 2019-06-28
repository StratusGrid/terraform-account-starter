module "restricted_admin" {
  source = "StratusGrid/iam-role-cross-account-trusting/aws"
  version = "1.0.8"
  # source = "github.com/StratusGrid/terraform-aws-iam-role-cross-account-trusting"
  role_name = "${var.name_prefix}-restricted-admin-role${local.name_suffix}"
  principal_arns = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  policy_arns = ["${aws_iam_policy.restricted_admin.arn}"]
  require_mfa = true
  input_tags  = "${merge(local.common_tags,
    map(
    )
  )}"
}
