###################################################
# Gateway Endpoints
###################################################

module "vpc_gateway_endpoint" {
  source  = "tedilabs/network/aws//modules/vpc-gateway-endpoint"
  version = "0.24.0"

  for_each = {
    for endpoint in local.config.vpc_endpoints.gateway :
    endpoint.name => endpoint
  }

  name = each.key

  service_name = each.value.service_name
  vpc_id       = module.vpc.id

  auto_accept = try(each.value.auto_accept, true)

  notification_configurations = []

  tags = merge(
    local.workspace_tags,
  )
}
