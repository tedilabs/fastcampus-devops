data "aws_ami" "latest" {
  for_each = toset(["1.20", "1.21"])

  owners      = ["602401143452"]
  most_recent = true

  filter {
    name = "name"
    values = [
      "amazon-eks-node-${each.value}-v*",
    ]
  }
}

module "node_group__app" {
  source  = "tedilabs/container/aws//modules/eks-node-group"
  version = "0.14.0"

  cluster_name = module.cluster.name
  name         = "${module.cluster.name}-app-v1.21"

  desired_size = 2
  min_size     = 1
  max_size     = 2

  instance_type    = "t3.small"
  instance_ami     = "ami-0073aeb06ceb4b0dc"
  instance_ssh_key = "fastcampus"
  instance_profile = module.cluster.iam_roles["node"].instance_profile_name

  associate_public_ip_address = true
  subnet_ids                  = local.subnet_groups["public"].ids
  security_group_ids = [
    module.cluster.security_group_ids["node"],
    module.security_group__node.id,
  ]

  # cni_custom_networking_enabled = true

  node_labels = {
    role = "app"
    team = "fastcampus"
  }
  node_taints = []
}
