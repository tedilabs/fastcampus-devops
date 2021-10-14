###################################################
# Subnet Groups
###################################################

module "subnet_group" {
  source  = "tedilabs/network/aws//modules/subnet-group"
  version = "0.24.0"

  for_each = local.config.subnet_groups

  name                    = "${module.vpc.name}-${each.key}"
  vpc_id                  = module.vpc.id
  map_public_ip_on_launch = try(each.value.map_public_ip_on_launch, false)

  subnets = {
    for idx, subnet in try(each.value.subnets, []) :
    "${module.vpc.name}-${each.key}-${format("%03d", idx + 1)}/${regex("az[0-9]", subnet.az_id)}" => {
      cidr_block           = subnet.cidr
      availability_zone_id = subnet.az_id
    }
  }

  db_subnet_group_enabled    = try(each.value.db_subnet_group_name != null, false)
  db_subnet_group_name       = try(each.value.db_subnet_group_name, null)
  cache_subnet_group_enabled = try(each.value.cache_subnet_group_name != null, false)
  cache_subnet_group_name    = try(each.value.cache_subnet_group_name, null)

  tags = merge(
    local.workspace_tags,
    try(each.value.tags, {}),
  )
}
