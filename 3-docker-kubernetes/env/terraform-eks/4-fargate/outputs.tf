output "cluster" {
  value = module.cluster
}

output "node_groups" {
  value = {
    app = module.node_group__app
  }
}

output "latest_instance_ami" {
  value = {
    for version, ami in data.aws_ami.latest :
    version => {
      id    = ami.id
      name  = ami.name
      owner = ami.image_owner_alias
    }
  }
}

output "irsa" {
  value = {
    "irsa-test"                    = module.irsa__irsa_test
    "aws-load-balancer-controller" = module.irsa__aws_load_balancer_controller
    "kubernetes-external-secrets"  = module.irsa__kubernetes_external_secrets
  }
}

output "fargate_profiles" {
  value = {
    "test" = aws_eks_fargate_profile.test
  }
}
