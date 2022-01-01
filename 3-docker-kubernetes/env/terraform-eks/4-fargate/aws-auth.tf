module "aws_auth" {
  source  = "tedilabs/container/aws//modules/eks-aws-auth"
  version = "0.14.0"

  node_roles            = [module.cluster.iam_roles.node.arn]
  fargate_profile_roles = [module.cluster.iam_roles.fargate_profile.arn]

  map_roles    = []
  map_users    = []
  map_accounts = []
}
