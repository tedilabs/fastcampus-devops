provider "local" {
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "local_file" "foo" {
  filename = "${path.module}/foo.txt"
  content  = "Hello World!"
}

data "local_file" "bar" {
  filename = "${path.module}/bar.txt"
}

output "file_bar" {
  value = data.local_file.bar
}

resource "aws_vpc" "foo" {
  cidr_block = "10.123.0.0/16"

  tags = {
    "Name" = "This is test vpc"
  }
}

output "vpc_foo" {
  value = aws_vpc.foo
}

data "aws_vpcs" "this" {}

output "vpcs" {
  value = data.aws_vpcs.this
}
