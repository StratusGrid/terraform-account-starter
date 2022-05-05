#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "s3_replication" {
  statement {
    sid = "AllowS3SourceReplication"
    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging"
    ]
    resources = [
      "arn:aws:s3:::${module.s3_bucket_logging_us_east_1.bucket_id}/*"
    ]
  }
  statement {
    sid = "AllowS3SourceReplicationMetadata"
    actions = [
      "s3:ListBucket",
      "s3:GetReplicationConfiguration"
    ]
    resources = [
      "arn:aws:s3:::${module.s3_bucket_logging_us_east_1.bucket_id}"
    ]
  }

  # Destination bucket objects
  statement {
    sid = "AllowS3SourceReplicationObjects"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
      "s3:ObjectOwnerOverrideToBucketOwner"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_destination_bucket_name}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_role_assumption" {
  name        = "S3-replication-policy"
  description = "Policy to allow S3 role assumption for centralized logging"
  policy      = data.aws_iam_policy_document.s3_replication.json
}


module "iam_role_s3" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4"

  trusted_role_services = ["s3.amazonaws.com"]

  create_role       = true
  role_requires_mfa = false #No MFA since it's a service

  role_name = "${var.name_prefix}-s3-central-replication${local.name_suffix}" #The assuming account matches it based upon name

  custom_role_policy_arns = [
    aws_iam_policy.s3_role_assumption.arn
  ]

  tags = {
    "Name" = "${var.name_prefix}-s3-central-replication${local.name_suffix}"
  }
}