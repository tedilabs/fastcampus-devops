module "sg" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "0.24.0"

  name        = "${local.vpc.name}-demo"
  description = "Security Group for demo."
  vpc_id      = local.vpc.id

  ingress_rules = [
    {
      id          = "all/all"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all communication from anywhere."
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
