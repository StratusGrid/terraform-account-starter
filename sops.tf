# KMS for SOPs
resource "aws_kms_key" "sops" {
  description         = "Default Key for SOPs"
  enable_key_rotation = true
}

# SOPs KMS Key Alias
resource "aws_kms_alias" "sops" {
  name          = "alias/${var.name_prefix}-sops-default-key${local.name_suffix}"
  target_key_id = aws_kms_key.sops.key_id
}
