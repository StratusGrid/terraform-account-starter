module "aws_anomaly_detection_alerts" {
  count      = var.payer_account == true ? 1 : 0 # Only enable if this is a payer account
  source     = "StratusGrid/anomaly-detection-alerts/aws"
  version    = "~> 3.0"
  input_tags = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over

  cost_threshold     = var.cost_anomaly_billing_threshold # This is a sample of $100
  subscription_email = var.cost_anomaly_subscription_email
}
