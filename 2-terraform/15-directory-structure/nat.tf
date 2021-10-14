locals {
  nat_subnets = {
    for subnet in module.subnet_group["net-public"].subnets :
    subnet.availability_zone_id => subnet.id...
  }
}

###################################################
# NAT Gateway
###################################################

module "nat_gw" {
  source  = "tedilabs/network/aws//modules/nat-gateway"
  version = "0.24.0"

  for_each = {
    for nat_gateway in local.config.nat_gateways :
    nat_gateway.az_id => nat_gateway
  }

  name      = "${module.vpc.name}-nat-gw/${regex("az[0-9]", each.key)}"
  subnet_id = try(local.nat_subnets[each.key][0], null)
  eip_id    = aws_eip.this[each.value.eip].id

  tags = merge(
    local.workspace_tags,
  )
}
