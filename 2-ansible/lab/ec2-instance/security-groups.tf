module "sg__ssh" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "0.24.0"

  name        = "${local.vpc.name}-ssh"
  description = "Security Group for SSH."
  vpc_id      = local.vpc.id

  ingress_rules = [
    {
      id          = "ssh"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH from anywhere."
    },
  ]
  egress_rules = []

  tags = local.common_tags
}


module "sg__openvpn" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "0.24.0"

  name        = "${local.vpc.name}-openvpn"
  description = "Security Group for OpenVPN."
  vpc_id      = local.vpc.id

  ingress_rules = [
    {
      id          = "openvpn/all"
      protocol    = "udp"
      from_port   = 1194
      to_port     = 1194
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow OpenVPN from anywhere."
    },
  ]
  egress_rules = [
    {
      id          = "all/all"
      description = "Allow to communicate to the Internet."
      protocol    = "-1"
      from_port   = 0
      to_port     = 0

      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  tags = local.common_tags
}

module "sg__grafana" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "0.24.0"

  name        = "${local.vpc.name}-grafana"
  description = "Security Group for Grafana."
  vpc_id      = local.vpc.id

  ingress_rules = [
    {
      id          = "grafana/vpc"
      protocol    = "tcp"
      from_port   = 3000
      to_port     = 3000
      cidr_blocks = ["10.0.0.0/8"]
      description = "Allow Grafana within VPC CIDRs."
    },
  ]
  egress_rules = [
    {
      id          = "all/all"
      description = "Allow to communicate to the Internet."
      protocol    = "-1"
      from_port   = 0
      to_port     = 0

      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  tags = local.common_tags
}

