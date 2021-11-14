variable "name" {
  type    = string
  default = "openvpn"
}

variable "description" {
  type    = string
  default = "AMI to operate OpenVPN on Ubuntu Linux in AWS EC2."
}

variable "region" {
  type    = string
  default = "ap-northeast-2"
}
