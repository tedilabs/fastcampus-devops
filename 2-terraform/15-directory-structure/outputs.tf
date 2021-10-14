output "config" {
  value = local.config
}

output "prefix_lists" {
  value = {
    ipv4 = {
      for name, prefix_list in aws_ec2_managed_prefix_list.ipv4 :
      name => {
        id      = prefix_list.id
        arn     = prefix_list.arn
        name    = prefix_list.name
        entries = prefix_list.entry
        version = prefix_list.version
      }
    }
    ipv6 = {
      for name, prefix_list in aws_ec2_managed_prefix_list.ipv6 :
      name => {
        id      = prefix_list.id
        arn     = prefix_list.arn
        name    = prefix_list.name
        entries = prefix_list.entry
        version = prefix_list.version
      }
    }
  }
}

output "vpc" {
  value = module.vpc
}

output "subnet_groups" {
  value = module.subnet_group
}

output "eip" {
  value = aws_eip.this
}

output "nat_gateway" {
  value = module.nat_gw
}

output "nacl" {
  value = module.nacl
}

output "gateway_endpoints" {
  value = module.vpc_gateway_endpoint
}
