data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  common_tags = {
    "Project" = "fastcampus-docker-kubernetes"
  }
}

resource "aws_instance" "demo" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t3.small"
  subnet_id     = local.subnet_groups["public"].ids[0]
  key_name      = "fastcampus"

  associate_public_ip_address = true
  vpc_security_group_ids = [
    module.sg.id,
  ]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.vpc.name}-demo"
    }
  )
}

resource "null_resource" "provisioner" {
  triggers = {
    insteance_id = aws_instance.demo.id
    install_docker = filemd5("${path.module}/files/install-docker.sh")
    install_docker_compose = filemd5("${path.module}/files/install-docker-compose.sh")
    install_kubectl = filemd5("${path.module}/files/install-kubectl.sh")
    install_kustomize = filemd5("${path.module}/files/install-kustomize.sh")
    install_minikube = filemd5("${path.module}/files/install-minikube.sh")
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/files/update-apt.sh",
      "${path.module}/files/install-docker.sh",
      "${path.module}/files/install-docker-compose.sh",
      "${path.module}/files/install-kubectl.sh",
      "${path.module}/files/install-kustomize.sh",
      "${path.module}/files/install-minikube.sh",
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.demo.public_ip
    }
  }
}
