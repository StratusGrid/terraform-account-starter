# https://api.slack.com/messaging/webhooks
/* resource "aws_ssm_parameter" "slack_webhook" {
  name      = "/${var.env_name}/${var.name_prefix}/service-limits/slack_webhook"
  type      = "String"
  value     = "https://hooks.slack.com/services/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"
  overwrite = true
}

resource "aws_ssm_parameter" "slack_channel_key" {
  name      = "/${var.env_name}/${var.name_prefix}/service-limits/slack_channel_key"
  type      = "String"
  value     = "alerts" # Channel Name without the # https://docs.aws.amazon.com/solutions/latest/limit-monitor/deployment.html#step3
  overwrite = true
} */

module "aws_limits" {
  source  = "github.com/StratusGrid/terraform-aws-limits-monitor.git?ref=dev"
  #version = "1.0.1"

  input_tags = merge(local.common_tags, {}) # Module input tags

  email = var.service_limit_email
}