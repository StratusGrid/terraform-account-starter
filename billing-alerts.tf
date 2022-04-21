module "aws_anomaly_detection_alerts" {
  source     = "https://github.com/StratusGrid/terraform-aws-anomaly-detection-alerts"
  version    = "1.0.0"
  name       = "${var.name_prefix}-anomaly-detection-alerts${local.name_suffix}"
  input_tags = merge(local.common_tags, {})

  cost_threshold     = 100                   # This is a sample of $100
  subscription_email = "mygroup@example.com" # please change this
}
