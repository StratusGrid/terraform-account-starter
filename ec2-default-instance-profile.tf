module "ec2_default_instance_profile" {
  source  = "StratusGrid/ec2-instance-profile-builder/aws"
  version = "2.0.0"

  instance_profile_name = "${var.name_prefix}-default-ec2-instance-profile${local.name_suffix}"
  input_tags            = merge(local.common_tags, {})
}

