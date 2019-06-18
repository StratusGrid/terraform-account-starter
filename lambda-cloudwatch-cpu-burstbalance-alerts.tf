module "cpu-burst-balance-lambda" {
  source = "StratusGrid/lambda-event-handler-cpu-creditbalance/aws"
  version = "1.0.2"
  name_prefix = "${var.name_prefix}"
  name_suffix = "${local.name_suffix}"
  unique_name = "event-handler-cpu-burst-balance"
  sns_alarm_target = "${aws_sns_topic.infrastructure_alerts.arn}"
  input_tags  = "${merge(local.common_tags,
    map(
    )
  )}"
}
