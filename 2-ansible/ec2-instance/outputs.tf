output "amazon_instance" {
  value = [
    for instance in aws_instance.amazon : {
      public_ip   = instance.public_ip
      public_dns  = instance.public_dns
      private_ip  = instance.private_ip
      private_dns = instance.private_dns
    }
  ]
}

output "ubuntu_instance" {
  value = [
    for instance in aws_instance.ubuntu : {
      public_ip   = instance.public_ip
      public_dns  = instance.public_dns
      private_ip  = instance.private_ip
      private_dns = instance.private_dns
    }
  ]
}
