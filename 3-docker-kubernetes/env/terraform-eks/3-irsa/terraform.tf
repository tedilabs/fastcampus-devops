###################################################
# Providers
###################################################

provider "aws" {
  region = "ap-northeast-2"
}

data "aws_eks_cluster_auth" "this" {
  name = module.cluster.name
}


provider "kubernetes" {
  host = module.cluster.endpoint

  cluster_ca_certificate = base64decode(module.cluster.ca_cert)
  token                  = data.aws_eks_cluster_auth.this.token
}
