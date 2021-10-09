# <BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
#   # Block body
#   <IDENTIFIER> = <EXPRESSION> # Argument
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.62.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  workspace_tags = {
    "Owner" = "posquit0"
  }
}

variable "aws_region" {
  default = "ap-northeast-2"
}

variable "base_cidr_block" {
  description = "A /16 CIDR range definition, such as 10.1.0.0/16, that the VPC will use"
  default     = "10.1.0.0/16"
}

resource "aws_vpc" "main" {
  # Referencing the base_cidr_block variable allows the network address
  # to be changed without modifying the configuration.
  cidr_block = var.base_cidr_block
}

module "vpc" {
  source  = "tedilabs/network/aws//modules/vpc"
  version = "0.24.0"

  name       = "fastcampus"
  cidr_block = var.base_cidr_block

  internet_gateway_enabled             = true
  egress_only_internet_gateway_enabled = false
  vpn_gateway_enabled                  = true

  dns_hostnames_enabled = true
  dns_support_enabled   = true

  tags = merge(
    local.workspace_tags,
    {}
  )
}

data "aws_vpcs" "this" {}

output "vpc_by_resource" {
  value = aws_vpc.main
}

output "vpc_by_module" {
  value = module.vpc
}

output "vpcs" {
  value = data.aws_vpcs.this
}
