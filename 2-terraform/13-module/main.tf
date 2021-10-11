provider "aws" {
  region = "ap-northeast-2"
}

module "account" {
  source = "./account"

  name = "posquit0-fastcampus"
  password_policy = {
    minimum_password_length        = 8
    require_numbers                = true
    require_symbols                = true
    require_lowercase_characters   = true
    require_uppercase_characters   = true
    allow_users_to_change_password = true
    hard_expiry                    = false
    max_password_age               = 0
    password_reuse_prevention      = 0
  }
}

output "id" {
  value = module.account.id
}

output "account_name" {
  value = module.account.name
}

output "signin_url" {
  value = module.account.signin_url
}

output "account_password_policy" {
  value = module.account.password_policy
}
