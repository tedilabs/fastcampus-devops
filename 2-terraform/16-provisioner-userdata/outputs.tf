output "provisioner_instance" {
  value = {
    public_ip   = aws_instance.provisioner.public_ip
    public_dns  = aws_instance.provisioner.private_dns
    private_ip  = aws_instance.provisioner.private_ip
    private_dns = aws_instance.provisioner.private_dns
  }
}

output "userdata_instance" {
  value = {
    public_ip   = aws_instance.userdata.public_ip
    public_dns  = aws_instance.userdata.public_dns
    private_ip  = aws_instance.userdata.private_ip
    private_dns = aws_instance.userdata.private_dns
  }
}
