module "restricted_approver" {
  count = var.aws_sso_enabled == false ? 1 : 0

  source         = "StratusGrid/iam-role-cross-account-trusting/aws"
  version        = "2.1.0"
  role_name      = "${var.name_prefix}-restricted-approver-role${local.name_suffix}"
  principal_arns = distinct(flatten(["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root", var.trusted_users_account_arns]))
  policy_arns    = [aws_iam_policy.approver_restrictions[0].arn, data.aws_iam_policy.approver_permission.arn, data.aws_iam_policy.approver_access.arn]
  require_mfa    = true
  input_tags     = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
}
