module "aws_config_rules_us_east_1" {
  count = var.control_tower_enabled == true ? 1 : 0

  source                        = "StratusGrid/config-rules/aws"
  version                       = "1.0.1"
  include_global_resource_rules = true #only include global resource on one region to prevent duplicate rules
  source_recorder               = module.aws_config_recorder_us_east_1.aws_config_configuration_recorder_id
  required_tags_enabled         = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  # tag1Key   = "Provisioner"
  # tag1Value = "Terraform"
  # tag2Key   = "Customer"
  # tag3Key   = "Application"

  providers = {
    aws = aws.us-east-1
  }

  depends_on = [
    module.aws_config_recorder_us_east_1
  ]
}

module "aws_config_rules_us_east_2" {
  count = var.control_tower_enabled == true ? 1 : 0

  source                = "StratusGrid/config-rules/aws"
  version               = "1.0.1"
  source_recorder       = module.aws_config_recorder_us_east_2.aws_config_configuration_recorder_id
  required_tags_enabled = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  providers = {
    aws = aws.us-east-2
  }
}

module "aws_config_rules_us_west_1" {
  source                = "StratusGrid/config-rules/aws"
  version               = "1.0.1"
  source_recorder       = module.aws_config_recorder_us_west_1.aws_config_configuration_recorder_id
  required_tags_enabled = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  providers = {
    aws = aws.us-west-1
  }
}

module "aws_config_rules_us_west_2" {
  source                = "StratusGrid/config-rules/aws"
  version               = "1.0.1"
  source_recorder       = module.aws_config_recorder_us_west_2.aws_config_configuration_recorder_id
  required_tags_enabled = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  providers = {
    aws = aws.us-west-2
  }
}

