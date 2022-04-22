module "aws_anomaly_detection_alerts" {
  count      = var.payer_account == true ? 1 : 0 # Only enable if this is a payer account
  source     = "StratusGrid/anomaly-detection-alerts/aws"
  version    = "~> 2.0.0"
  name       = "${var.name_prefix}-anomaly-detection-alerts${local.name_suffix}"
  input_tags = merge(local.common_tags, {})

  cost_threshold     = var.cost_anomaly_billing_threshold # This is a sample of $100
  subscription_email = var.cost_anomaly_subscription_email
}
