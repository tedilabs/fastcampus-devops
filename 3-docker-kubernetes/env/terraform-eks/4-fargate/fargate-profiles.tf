resource "aws_eks_fargate_profile" "test" {
  fargate_profile_name = "test"

  cluster_name           = module.cluster.name
  pod_execution_role_arn = module.cluster.iam_roles.fargate_profile.arn
  subnet_ids             = local.subnet_groups["private"].ids

  selector {
    namespace = "fastcampus"
    labels    = {
      "eks.amazonaws.com/compute-type" = "fargate"
    }
  }

  tags = merge(
    {
      "Name" = "test"
    },
  )
}
