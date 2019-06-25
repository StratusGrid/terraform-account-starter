# infrastructure_alerts is used to alert on infrastructure monitoring alarms etc.
resource "aws_sns_topic" "infrastructure_alerts" {
  name = "${var.name_prefix}-infrastructure-alerts${local.name_suffix}"
  tags = "${merge(local.common_tags,
    map(
    )
  )}"
}

resource "aws_sns_topic" "aws_config_stream" {
  name = "${var.name_prefix}-aws-config-stream${local.name_suffix}"
  tags = "${merge(local.common_tags,
    map(
    )
  )}"
}
