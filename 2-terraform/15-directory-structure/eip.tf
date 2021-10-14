resource "aws_eip" "this" {
  for_each = toset(local.config.eip)

  tags = merge(
    {
      "Name" = each.value
    },
    local.workspace_tags,
  )
}
