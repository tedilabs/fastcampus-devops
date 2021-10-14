resource "aws_default_network_acl" "this" {
  default_network_acl_id = module.vpc.default_network_acl_id

  tags = merge(
    {
      "Name" = "${module.vpc.name}-default"
    },
    local.workspace_tags,
  )

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}


###################################################
# Custom Network ACLs
###################################################

module "nacl" {
  source  = "tedilabs/network/aws//modules/nacl"
  version = "0.24.0"

  for_each = local.config.nacl

  name   = "${module.vpc.name}-${each.key}"
  vpc_id = module.vpc.id
  subnets = concat(
    module.subnet_group[each.key].ids,
  )

  ingress_rules = try(each.value.ingress_rules, {})
  egress_rules  = try(each.value.egress_rules, {})

  tags = merge(
    local.workspace_tags,
  )
}
