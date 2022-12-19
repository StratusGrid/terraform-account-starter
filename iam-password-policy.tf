# tfsec:ignore:aws-iam-set-max-password-age ignoring the max time for passwords since users will use SSO and less than 90 days password rotation will be disruptive for applications
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 16
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 10
}
