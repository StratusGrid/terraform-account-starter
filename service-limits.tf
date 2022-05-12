# https://api.slack.com/messaging/webhooks
/* resource "aws_ssm_parameter" "slack_webhook" {
  name      = "/${var.env_name}/${var.name_prefix}/service-limits/slack_webhook"
  type      = "String"
  value     = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
  overwrite = true
}

resource "aws_ssm_parameter" "slack_channel_key" {
  name      = "/${var.env_name}/${var.name_prefix}/service-limits/slack_channel_key"
  type      = "String"
  value     = "channelname" # Channel Name without the # https://docs.aws.amazon.com/solutions/latest/limit-monitor/deployment.html#step3
  overwrite = true
} */

module "aws_limits" {
  source  = "StratusGrid/limits-monitor/aws"
  version = "1.0.2"

  input_tags = merge() # Module input tags

  email = var.service_limit_email
}