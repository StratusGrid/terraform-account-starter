module "ebs_burst_balance_lambda" {
  count = 0

  source  = "StratusGrid/lambda-event-handler-ebs-burstbalance/aws"
  version = "2.1.0"

  name_prefix                 = var.name_prefix
  name_suffix                 = local.name_suffix
  unique_name                 = "event-handler-ebs-burst-balance"
  sns_alarm_target            = aws_sns_topic.infrastructure_alerts.arn
  kms_log_key_deletion_window = 30
  input_tags                  = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
}
