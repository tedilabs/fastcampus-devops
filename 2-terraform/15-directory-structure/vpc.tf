locals {
  private_zones = merge(
    local.domain_zones.private_zones,
  )
}

module "vpc" {
  source  = "tedilabs/network/aws//modules/vpc"
  version = "0.24.0"

  name                  = local.config.vpc.name
  cidr_block            = local.config.vpc.cidr
  secondary_cidr_blocks = local.config.vpc.secondary_cidrs
  ipv6_enabled          = false

  internet_gateway_enabled             = true
  egress_only_internet_gateway_enabled = false

  vpn_gateway_enabled = true
  vpn_gateway_asn     = local.config.vpc.vpn_gateway_asn

  dns_hostnames_enabled = true
  dns_support_enabled   = true
  private_hosted_zones = [
    for zone in try(local.config.vpc.private_zones, []) :
    local.private_zones[zone].id
  ]

  dhcp_options_enabled = true

  tags = merge(
    local.workspace_tags,
  )
}
