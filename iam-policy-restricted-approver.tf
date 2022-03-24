data "aws_iam_policy" "approver_access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy" "approver_permission" {
  arn = "arn:aws:iam::aws:policy/AWSCodePipelineApproverAccess"
}

data "aws_iam_policy_document" "approver_restrictions" {
  statement {
    effect = "Deny"
    actions = [
      "s3:GetObject",
      "lambda:GetFunction",
      "workdocs:Get*",
      "workmail:Get*",
      "athena:GetQueryResults*",
    ]
    not_resources = [
      "${module.s3_bucket_logging_us_east_1.bucket_arn}/*",
      "${module.s3_bucket_logging_us_east_2.bucket_arn}/*",
      "${module.s3_bucket_logging_us_west_1.bucket_arn}/*",
      "${module.s3_bucket_logging_us_west_2.bucket_arn}/*",
      # "${module.cloudtrail.s3_bucket_arn}/*",
    ]
    sid = "DenyReadOnlyDataRetrieval"
  }
  statement {
    effect = "Deny"
    actions = [
      "secretsmanager:GetSecretValue",
      "ec2:GetPasswordData",
      "redshift:GetClusterCredentials",
      "cognito-identity:GetCredentialsForIdentity",
      "cognito-identity:GetId",
      "cognito-identity:GetOpenIdToken",
    ]
    resources = [
      "*",
    ]
    sid = "DenyReadOnlySecrets"
  }
}

resource "aws_iam_policy" "approver_restrictions" {
  count = var.aws_sso_enabled == false ? 1 : 0

  name        = "${var.name_prefix}-approver-restrictions${local.name_suffix}"
  description = "Policy to restrict approver users from accessing data and secrets."
  policy      = data.aws_iam_policy_document.read_only_restrictions.json
}
