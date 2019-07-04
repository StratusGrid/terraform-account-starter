#With the current code, and on version .11.x, you need to apply the policy one time with -target before this, or face a 'count' error
module "restricted_read_only" {
  source = "StratusGrid/iam-role-cross-account-trusting/aws"
  version = "1.0.8"
  # source = "github.com/StratusGrid/terraform-aws-iam-role-cross-account-trusting"
  role_name = "${var.name_prefix}-restricted-read-only-role${local.name_suffix}"
  principal_arns = ["arn:aws:iam::${var.users_account_number}:root"]
  policy_arns = ["${aws_iam_policy.read_only_restrictions.arn}","${data.aws_iam_policy.read_only_access.arn}"]
  require_mfa = true
  input_tags  = "${merge(local.common_tags,
    map(
    )
  )}"
}
