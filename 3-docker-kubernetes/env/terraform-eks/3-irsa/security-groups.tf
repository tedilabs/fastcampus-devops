module "security_group__node" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "0.24.0"

  name        = "${module.cluster.name}-node-user"
  description = "Security group for EKS nodes."
  vpc_id      = local.vpc.id

  ingress_rules = [
    {
      id          = "ssh/cidrs"
      description = "Allow CIDRs to communicate with MySQL Server."
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22

      cidr_blocks = [local.vpc.cidr_block]
    },
  ]
  egress_rules = [
    {
      id          = "all/all"
      description = "Allow nodes to communicate to the Internet."
      protocol    = "-1"
      from_port   = 0
      to_port     = 0

      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}
