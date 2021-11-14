terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "fastcampus-devops"

    workspaces {
      name = "terraform-lab-openvpn"
    }
  }
}


###################################################
# Local Variables
###################################################

locals {
  context = yamldecode(file(var.config_file)).context
  config  = yamldecode(templatefile(var.config_file, local.context))
}


###################################################
# Providers
###################################################

provider "aws" {
  region = "ap-northeast-2"
}
