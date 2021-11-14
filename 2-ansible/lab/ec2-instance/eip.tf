resource "aws_eip" "openvpn" {
  tags = merge(
    {
      "Name" = "${local.vpc.name}-openvpn"
    },
    local.common_tags,
  )
}

resource "aws_eip_association" "openvpn" {
  instance_id   = aws_instance.openvpn.id
  allocation_id = aws_eip.openvpn.id
}
