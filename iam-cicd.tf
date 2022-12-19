data "aws_iam_policy_document" "cicd" {
  statement {
    sid = "AllowFullAdminExceptSomeWithMFA"
    not_actions = [
      "logs:Delete*",
      "cloudtrail:Delete*",
      "cloudtrail:Stop*",
      "cloudtrail:Update*",
      "sts:AssumeRoleWithSAML",
      "sts:AssumeRoleWithWebIdentity",
      "sts:GetFederationToken",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "cicd" {
  count = var.tooling_account_id == "" ? 0 : 1

  name        = "CICD-policy"
  description = "Policy to grant restricted admin for the CICD role. This admin can't do some functions such as delete the CloudTrail audit trail."
  policy      = data.aws_iam_policy_document.cicd.json
}


module "iam_role_cicd" {
  count = var.tooling_account_id == "" ? 0 : 1

  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.9"

  trusted_role_arns = [
    "arn:aws:iam::${var.tooling_account_id}:root" # The "tooling" account must be allowed to assume this role to perform actions in this account
  ]

  create_role = true

  role_name         = "${var.name_prefix}-pipeline-role-CICD" #The assuming account matches it based upon name
  role_requires_mfa = false

  custom_role_policy_arns = [
    aws_iam_policy.cicd.arn
  ]

  tags = merge({ "Name" = "${var.name_prefix}-pipeline-role-CICD${local.name_suffix}" })
}
