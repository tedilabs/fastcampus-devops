resource "aws_ec2_managed_prefix_list" "ipv4" {
  for_each = {
    for prefix_list in local.config.prefix_lists.ipv4 :
    prefix_list.name => prefix_list
  }

  name           = each.key
  address_family = "IPv4"
  max_entries    = each.value.max_entries

  dynamic "entry" {
    for_each = each.value.entries

    content {
      cidr        = entry.value.cidr
      description = entry.value.description
    }
  }

  tags = merge(
    {
      "Name" = each.key
    },
    local.workspace_tags,
  )
}

resource "aws_ec2_managed_prefix_list" "ipv6" {
  for_each = {
    for prefix_list in local.config.prefix_lists.ipv6 :
    prefix_list.name => prefix_list
  }

  name           = each.key
  address_family = "IPv6"
  max_entries    = each.value.max_entries

  dynamic "entry" {
    for_each = each.value.entries

    content {
      cidr        = entry.value.cidr
      description = entry.value.description
    }
  }

  tags = merge(
    {
      "Name" = each.key
    },
    local.workspace_tags,
  )
}
