terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "fastcampus-devops"

    workspaces {
      name = "aws-network-apne2-fastcampus"
    }
  }
}


###################################################
# Local Variables
###################################################

locals {
  aws_accounts = {
    fastcampus = {
      id     = "xxxxxxxxxx"
      region = "ap-northeast-2"
      alias  = "posquit0-fastcampus"
    },
  }
  context = yamldecode(file(var.config_file)).context
  config  = yamldecode(templatefile(var.config_file, local.context))
}


###################################################
# Providers
###################################################

provider "aws" {
  region = local.aws_accounts.fastcampus.region

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = [local.aws_accounts.fastcampus.id]

  assume_role {
    role_arn     = "arn:aws:iam::${local.aws_accounts.fastcampus.id}:role/terraform-access"
    session_name = local.context.workspace
  }
}
