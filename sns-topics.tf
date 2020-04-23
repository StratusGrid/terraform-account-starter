# infrastructure_alerts is used to alert on infrastructure monitoring alarms etc.
resource "aws_sns_topic" "infrastructure_alerts" {
  name = "${var.name_prefix}-infrastructure-alerts${local.name_suffix}"
  tags = merge(local.common_tags, {})
  provider = aws.us-east-1
}
