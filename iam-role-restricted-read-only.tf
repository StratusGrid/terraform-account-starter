module "restricted_read_only" {
  source  = "StratusGrid/iam-role-cross-account-trusting/aws"
  version = "2.0.0"
  # source = "github.com/StratusGrid/terraform-aws-iam-role-cross-account-trusting"

  role_name      = "${var.name_prefix}-restricted-read-only-role${local.name_suffix}"
  principal_arns = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  policy_arns    = [aws_iam_policy.read_only_restrictions.arn, data.aws_iam_policy.read_only_access.arn]
  require_mfa    = true
  input_tags     = merge(local.common_tags, {})
}

