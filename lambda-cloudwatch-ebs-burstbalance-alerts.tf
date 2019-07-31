module "ebs_burst_balance_lambda" {
  source  = "StratusGrid/lambda-event-handler-ebs-burstbalance/aws"
  version = "2.0.0"
  # source  = "github.com/StratusGrid/terraform-aws-lambda-event-handler-ebs-burstbalance"
  
  name_prefix      = var.name_prefix
  name_suffix      = local.name_suffix
  unique_name      = "event-handler-ebs-burst-balance"
  sns_alarm_target = aws_sns_topic.infrastructure_alerts.arn
  input_tags       = merge(local.common_tags, {})
}

