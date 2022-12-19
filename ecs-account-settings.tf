resource "aws_ecs_account_setting_default" "service_long_arn_format" {
  name  = "serviceLongArnFormat"
  value = "enabled"
}

resource "aws_ecs_account_setting_default" "task_long_arn_format" {
  name  = "taskLongArnFormat"
  value = "enabled"
}

resource "aws_ecs_account_setting_default" "container_instance_long_arn_format" {
  name  = "containerInstanceLongArnFormat"
  value = "enabled"
}

resource "aws_ecs_account_setting_default" "aws_vpc_trunking" {
  name  = "awsvpcTrunking"
  value = "enabled"
}

resource "aws_ecs_account_setting_default" "container_insights" {
  name  = "containerInsights"
  value = "enabled"
}