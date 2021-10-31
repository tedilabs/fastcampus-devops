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

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

locals {
  common_tags = {
    "Project" = "fastcampus-ansible"
  }
}

resource "aws_instance" "amazon" {
  count = 2

  ami           = data.aws_ami.amazon.image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["public"].ids[0]
  key_name      = "fastcampus"

  associate_public_ip_address = true
  vpc_security_group_ids = [
    module.sg__ssh.id,
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.vpc.name}-amazon-linux-2"
    }
  )
}

resource "aws_instance" "ubuntu" {
  count = 2

  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["public"].ids[0]
  key_name      = "fastcampus"

  associate_public_ip_address = true
  vpc_security_group_ids = [
    module.sg__ssh.id,
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.vpc.name}-ubuntu"
    }
  )
}
