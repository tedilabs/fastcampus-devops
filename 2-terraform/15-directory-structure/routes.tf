resource "aws_default_route_table" "this" {
  default_route_table_id = module.vpc.default_route_table_id

  tags = merge(
    {
      "Name" = "${module.vpc.name}-default"
    },
    local.workspace_tags,
  )
}


###################################################
# Route Tables for App Subnets
###################################################

module "route_table__app_private" {
  source  = "tedilabs/network/aws//modules/route-table"
  version = "0.24.0"

  for_each = toset(["apne2-az1", "apne2-az2", "apne2-az3"])

  name   = "${module.vpc.name}-app-private/${regex("az[0-9]", each.value)}"
  vpc_id = module.vpc.id

  subnets = [
    for subnet in concat(
      module.subnet_group["app-private"].subnets,
      module.subnet_group["app-private-pod"].subnets,
    ) :
    subnet.id
    if subnet.availability_zone_id == each.value
  ]
  vpc_gateway_endpoints = [
    for endpoint in module.vpc_gateway_endpoint :
    endpoint.id
  ]

  ipv4_routes = [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = module.nat_gw[each.value].id
    },
  ]
  prefix_list_routes = []

  tags = merge(
    local.workspace_tags,
  )
}


###################################################
# Route Tables for Data Subnets
###################################################

module "route_table__data_private_managed" {
  source  = "tedilabs/network/aws//modules/route-table"
  version = "0.24.0"

  for_each = toset(["apne2-az1", "apne2-az2", "apne2-az3"])

  name   = "${module.vpc.name}-data-private-managed/${regex("az[0-9]", each.value)}"
  vpc_id = module.vpc.id

  subnets = [
    for subnet in concat(
      module.subnet_group["data-private-managed"].subnets,
    ) :
    subnet.id
    if subnet.availability_zone_id == each.value
  ]
  vpc_gateway_endpoints = [
    for endpoint in module.vpc_gateway_endpoint :
    endpoint.id
  ]

  ipv4_routes = []
  prefix_list_routes = []

  tags = merge(
    local.workspace_tags,
  )
}

module "route_table__data_private_self" {
  source  = "tedilabs/network/aws//modules/route-table"
  version = "0.24.0"

  for_each = toset(["apne2-az1", "apne2-az2", "apne2-az3"])

  name   = "${module.vpc.name}-data-private-self/${regex("az[0-9]", each.value)}"
  vpc_id = module.vpc.id

  subnets = [
    for subnet in concat(
      module.subnet_group["data-private-self"].subnets,
    ) :
    subnet.id
    if subnet.availability_zone_id == each.value
  ]
  vpc_gateway_endpoints = [
    for endpoint in module.vpc_gateway_endpoint :
    endpoint.id
  ]

  ipv4_routes = [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = module.nat_gw[each.value].id
    },
  ]
  prefix_list_routes = []

  tags = merge(
    local.workspace_tags,
  )
}


###################################################
# Route Tables for Network Subnets
###################################################

module "route_table__net_public" {
  source  = "tedilabs/network/aws//modules/route-table"
  version = "0.24.0"

  for_each = toset(["apne2-az1", "apne2-az2", "apne2-az3"])

  name   = "${module.vpc.name}-net-public/${regex("az[0-9]", each.value)}"
  vpc_id = module.vpc.id

  subnets = [
    for subnet in concat(
      module.subnet_group["net-public"].subnets,
    ) :
    subnet.id
    if subnet.availability_zone_id == each.value
  ]
  vpc_gateway_endpoints = [
    for endpoint in module.vpc_gateway_endpoint :
    endpoint.id
  ]

  ipv4_routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.vpc.internet_gateway_id
    },
  ]
  prefix_list_routes = []

  tags = merge(
    local.workspace_tags,
  )
}

module "route_table__net_private" {
  source  = "tedilabs/network/aws//modules/route-table"
  version = "0.24.0"

  for_each = toset(["apne2-az1", "apne2-az2", "apne2-az3"])

  name   = "${module.vpc.name}-net-private/${regex("az[0-9]", each.value)}"
  vpc_id = module.vpc.id

  subnets = [
    for subnet in concat(
      module.subnet_group["net-private"].subnets,
    ) :
    subnet.id
    if subnet.availability_zone_id == each.value
  ]
  vpc_gateway_endpoints = [
    for endpoint in module.vpc_gateway_endpoint :
    endpoint.id
  ]

  ipv4_routes = [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = module.nat_gw[each.value].id
    },
  ]
  prefix_list_routes = []

  tags = merge(
    local.workspace_tags,
  )
}
