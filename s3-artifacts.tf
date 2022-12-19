data "aws_iam_policy_document" "artifacts_bucket_policy" {
  count = var.tooling_account == true ? 1 : 0
  statement {
    sid = "AllPikselAccountsAccessToBucket"
    principals {
      type        = "AWS"
      identifiers = var.piksel_accounts_list
    }

    actions = ["s3:ListBucket"]

    resources = [module.accounts_artifacts_bucket[0].s3_bucket_arn]
  }

  statement {
    sid = "AllPikselAccountsAccessToObjects"

    principals {
      type        = "AWS"
      identifiers = var.piksel_accounts_list
    }

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion"
    ]

    resources = [
      "${module.accounts_artifacts_bucket[0].s3_bucket_arn}/*" #tfsec:ignore:aws-iam-no-policy-wildcards ignore warning as prefixes aren't used here.
    ]
  }
}

# Creates an S3 bucket which will hold build/deploy artifacts for the infrastructure and application pipelines
module "accounts_artifacts_bucket" {
  count = var.tooling_account == true ? 1 : 0

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "${var.name_prefix}-pipeline-artifacts${local.name_suffix}"
  force_destroy = false

  # Bucket policies
  attach_policy                         = true
  policy                                = data.aws_iam_policy_document.artifacts_bucket_policy[0].json
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Encryption at rest
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    enabled = true
  }

  # Object Retention Rule
  lifecycle_rule = [
    {
      id      = "Object-Archiving"
      enabled = true

      transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
    }
  ]
}
