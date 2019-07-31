#Uncomment iam user configuration if you don't want local users used. For instance, when using identity providers.
data "aws_iam_policy_document" "restricted_admin" {
  statement {
    not_actions = [
      # "iam:CreateUser",
      # "iam:CreateGroup",
      # "iam:DeleteUser",
      # "iam:DeleteGroup",
      "logs:Delete*",
      "cloudtrail:Delete*",
      "cloudtrail:Stop*",
      "cloudtrail:Update*",
      "sts:AssumeRole",
      "sts:AssumeRoleWithSAML",
      "sts:AssumeRoleWithWebIdentity",
      "sts:GetFederationToken",
    ]
    resources = [
      "*",
    ]
    sid = "AllowFullAdminExceptSome"
  }
  statement {
    not_actions = [
      "s3:Delete*",
      "s3:Put*",
    ]
    resources = [
      module.cloudtrail.s3_bucket_arn,
      "${module.cloudtrail.s3_bucket_arn}/*",
    ]
    sid = "AllowFullAdminExceptSomeS3"
  }
}

resource "aws_iam_policy" "restricted_admin" {
  name        = "${var.name_prefix}-restricted-admin${local.name_suffix}"
  description = "Policy to grant restricted admin. This admin can't do some functions such as delete the CloudTrail audit trail."
  policy      = data.aws_iam_policy_document.restricted_admin.json
}

