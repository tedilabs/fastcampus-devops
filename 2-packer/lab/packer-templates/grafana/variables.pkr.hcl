variable "name" {
  type    = string
  default = "grafana"
}

variable "description" {
  type    = string
  default = "AMI to operate Grafana on Ubuntu Linux in AWS EC2."
}

variable "region" {
  type    = string
  default = "ap-northeast-2"
}
