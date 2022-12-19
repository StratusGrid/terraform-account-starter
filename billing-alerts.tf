module "aws_anomaly_detection_alerts" {
  count = var.payer_account == true ? 1 : 0 # Only enable if this is a payer account

  source  = "StratusGrid/anomaly-detection-alerts/aws"
  version = "~> 3.0"

  enable_cost_anomaly_detection = var.payer_account

  input_tags = merge() # Common tags applied at provider level - additional tags may be added here

  cost_threshold     = var.cost_anomaly_billing_threshold # This is a sample of $100
  subscription_email = var.cost_anomaly_subscription_email
}
