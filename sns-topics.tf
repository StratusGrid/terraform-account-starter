# KMS for SNS
resource "aws_kms_key" "sns_topics" {
  description         = "Default key for infrastructure_alerts"
  enable_key_rotation = true
}

# SNS Topic KMS Key
resource "aws_kms_alias" "sns_topics" {
  name          = "alias/${var.name_prefix}-sns_topics-default-key${local.name_suffix}"
  target_key_id = aws_kms_key.sns_topics.key_id

  depends_on = [aws_kms_key.sns_topics]
}

# Infrastructure_alerts is used to alert on infrastructure monitoring alarms etc.
resource "aws_sns_topic" "infrastructure_alerts" {
  name     = "${var.name_prefix}-infrastructure-alerts${local.name_suffix}"
  provider = aws.us-east-1

  kms_master_key_id = aws_kms_alias.sns_topics.arn
}
