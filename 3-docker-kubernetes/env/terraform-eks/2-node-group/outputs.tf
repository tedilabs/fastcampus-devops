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
