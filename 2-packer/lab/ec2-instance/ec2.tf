data "aws_ami" "fastcampus" {
  for_each = toset([
    "openvpn",
    "grafana",
  ])

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/20.04/amd64/${each.key}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

resource "aws_instance" "grafana" {
  ami           = data.aws_ami.fastcampus["grafana"].image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["private"].ids[0]
  key_name      = "fastcampus"

  vpc_security_group_ids = [
    module.sg__ssh.id,
    module.sg__grafana.id,
  ]

  tags = {
    Name = "${local.vpc.name}-grafana"
  }
}

locals {
  openvpn_userdata = templatefile("${path.module}/files/openvpn-userdata.sh", {
    vpc_cidr  = local.vpc.cidr_block
    public_ip = aws_eip.openvpn.public_ip
  })
  common_tags = {
    "Project" = "openvpn"
  }
}

resource "aws_instance" "openvpn" {
  ami           = data.aws_ami.fastcampus["openvpn"].image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["public"].ids[0]
  key_name      = "fastcampus"

  user_data = local.openvpn_userdata

  associate_public_ip_address = false
  vpc_security_group_ids = [
    module.sg__ssh.id,
    module.sg__openvpn.id,
  ]

  tags = {
    Name = "${local.vpc.name}-openvpn"
  }

  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
    ]
  }
}
