data "aws_iam_policy" "read_only_access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "read_only_restrictions" {
  statement {
    effect    = "Deny"
    actions   = [
      "s3:GetObject",
      "lambda:GetFunction",
      "workdocs:Get*",
      "workmail:Get*",
      "athena:GetQueryResults*"
    ]
    not_resources = [
      "${module.s3_bucket_logging.bucket_arn}/*",
      "${module.cloudtrail.s3_bucket_arn}/*"
    ]
    sid       = "DenyReadOnlyDataRetrieval"
  }
  statement {
    effect    = "Deny"
    actions   = [
      "secretsmanager:GetSecretValue",
      "ec2:GetPasswordData",
      "redshift:GetClusterCredentials",
      "cognito-identity:GetCredentialsForIdentity",
      "cognito-identity:GetId",
      "cognito-identity:GetOpenIdToken"
    ]
    resources = [
      "*"
    ]
    sid       = "DenyReadOnlySecrets"
  }
}

resource "aws_iam_policy" "read_only_restrictions" {
  name        = "${var.name_prefix}-read-only-restrictions${local.name_suffix}"
  description = "Policy to restrict read only users from accessing data and secrets."
  policy      = "${data.aws_iam_policy_document.read_only_restrictions.json}"
}