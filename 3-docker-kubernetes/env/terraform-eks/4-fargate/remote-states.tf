locals {
  remote_states = {
    "network" = data.terraform_remote_state.network.outputs
  }
  vpc           = local.remote_states["network"].vpc
  subnet_groups = local.remote_states["network"].subnet_groups
}


###################################################
# Terraform Remote States (External Dependencies)
###################################################

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "${path.module}/../../terraform-aws-ubuntu/network/terraform.tfstate"
  }
}
