module "guard_duty_notifications" {
  count = var.guardduty_notifications_enabled == true ? 1 : 0 # Default of "false" prevents creation unless overridden

  source  = "StratusGrid/guard-duty-notifications/aws"
  version = "~> 1.0"

  input_tags = merge() # Common tags applied at provider level - additional tags may be added here
}