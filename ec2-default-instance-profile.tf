module "ec2_default_instance_profile" {
  source                = "StratusGrid/ec2-instance-profile-builder/aws"
  version               = "1.0.2"
  # source                = "github.com/StratusGrid/terraform-aws-ec2-instance-profile-builder"
  instance_profile_name = "${var.name_prefix}-default-ec2-instance-profile${local.name_suffix}"
  input_tags            = "${merge(local.common_tags,
    map(
    )
  )}"
}