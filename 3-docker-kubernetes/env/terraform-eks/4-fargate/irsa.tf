module "irsa__irsa_test" {
  source  = "tedilabs/container/aws//modules/eks-irsa"
  version = "0.14.0"

  name        = "irsa-${module.cluster.name}-app-irsa-test"
  description = "EKS IAM Role for Service Account of irsa-test app."

  oidc_provider_urls       = [module.cluster.oidc_provider_urn]
  trusted_service_accounts = ["fastcampus:irsa-test"]

  inline_policies = {
    "this" = file("policies/irsa-test.json")
  }
}

module "irsa__aws_load_balancer_controller" {
  source  = "tedilabs/container/aws//modules/eks-irsa"
  version = "0.14.0"

  name        = "irsa-${module.cluster.name}-addon-aws-load-balancer-controller"
  description = "EKS IAM Role for Service Account of AWS LoadBalancer Controller Addon."

  oidc_provider_urls       = [module.cluster.oidc_provider_urn]
  trusted_service_accounts = ["kube-system:aws-load-balancer-controller"]

  inline_policies = {
    "this" = file("policies/aws-load-balancer-controller.json")
  }
}

module "irsa__kubernetes_external_secrets" {
  source  = "tedilabs/container/aws//modules/eks-irsa"
  version = "0.14.0"

  name        = "irsa-${module.cluster.name}-addon-kubernetes-external-secrets"
  description = "EKS IAM Role for Service Account of Kubernetes External Secrets."

  oidc_provider_urls       = [module.cluster.oidc_provider_urn]
  trusted_service_accounts = ["kube-system:kubernetes-external-secrets"]

  inline_policies = {
    "this" = file("policies/kubernetes-external-secrets.json")
  }
}
