module "cost_billing_alarm" {
  source                    = "binbashar/cost-billing-alarm/aws"
  version                   = "1.0.12"
  monthly_billing_threshold = var.monthly_billing_threshold
  currency                  = var.currency
  aws_env                   = var.env_name
}