data "aws_iam_policy" "approver_access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy" "approver_permission" {
  arn = "arn:aws:iam::aws:policy/AWSCodePipelineApproverAccess"
}

resource "aws_iam_policy" "approver_restrictions" {
  count = var.aws_sso_enabled == false ? 1 : 0

  name        = "${var.name_prefix}-approver-restrictions${local.name_suffix}"
  description = "Policy to restrict approver users from accessing data and secrets."
  policy      = data.aws_iam_policy_document.read_only_restrictions.json
}
