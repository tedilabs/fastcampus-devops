data "aws_caller_identity" "this" {}


###################################################
# AWS Account Alias
###################################################

resource "aws_iam_account_alias" "this" {
  account_alias = var.name
}


###################################################
# Password Policy for AWS Account and IAM Users
###################################################

resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = var.password_policy.minimum_password_length
  require_numbers                = var.password_policy.require_numbers
  require_symbols                = var.password_policy.require_symbols
  require_lowercase_characters   = var.password_policy.require_lowercase_characters
  require_uppercase_characters   = var.password_policy.require_uppercase_characters
  allow_users_to_change_password = var.password_policy.allow_users_to_change_password
  hard_expiry                    = var.password_policy.hard_expiry
  max_password_age               = var.password_policy.max_password_age
  password_reuse_prevention      = var.password_policy.password_reuse_prevention
}
