# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/S3ExportTasksConsole.html
# Using indexes due to count if statements
#tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket" "central_logging" {
  count  = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0
  bucket = "${var.name_prefix}-central-logging${local.name_suffix}" # Globally unique
}

resource "aws_s3_bucket_acl" "central_logging" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  bucket = aws_s3_bucket.central_logging[0].id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "central_logging" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  bucket = aws_s3_bucket.central_logging[0].id

  # Delete after var.log_archive_retention days
  rule {
    expiration {
      days = var.log_archive_retention
    }

    id = "delete_after_${var.log_archive_retention}"

    status = "Enabled"

    # Move everything to IA after 30 days
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "central_logging" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  bucket = aws_s3_bucket.central_logging[0].bucket

  # Will use the AWS S3 KMS Master Key
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "central_logging" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  bucket = aws_s3_bucket.central_logging[0].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "central_logging" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  bucket = aws_s3_bucket.central_logging[0].id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "central_logging" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  bucket = aws_s3_bucket.central_logging[0].id
  policy = data.aws_iam_policy_document.central_logging[0].json
}

data "aws_iam_policy_document" "central_logging" {
  count = var.log_archive_account == true && var.enable_centralized_logging == true ? 1 : 0

  # Allow other accounts in the org to get bucket metadata
  statement {
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ObjectOwnerOverrideToBucketOwner"
    ]
    # Allow other accounts in the org to replicate bucket objects
    condition {
      test = "StringEquals"
      values = [
        var.aws_org_id
      ]
      variable = "aws:PrincipalOrgID"
    }
    # Only allow assumed roles
    condition {
      test = "StringEquals"
      values = [
        "AssumedRole"
      ]
      variable = "aws:PrincipalType"
    }
    effect = "Allow"
    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }
    resources = [
      "${aws_s3_bucket.central_logging[0].arn}/*"
    ]
    sid = "Set permissions for objects"
  }

  # Allow other accounts in the org to replicate to this central bucket
  statement {
    actions = [
      "s3:List*",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning"
    ]
    # Allow our entire org
    condition {
      test = "StringEquals"
      values = [
        var.aws_org_id
      ]
      variable = "aws:PrincipalOrgID"
    }
    # Only allow assumed roles
    condition {
      test = "StringEquals"
      values = [
        "AssumedRole"
      ]
      variable = "aws:PrincipalType"
    }
    effect = "Allow"
    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }
    resources = [
      aws_s3_bucket.central_logging[0].arn
    ]
    sid = "Set permissions on bucket"
  }
}
