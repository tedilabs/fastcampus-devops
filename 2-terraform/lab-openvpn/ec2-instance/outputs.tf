output "openvpn_instance" {
  value = {
    public_ip   = aws_eip.openvpn.public_ip
    public_dns  = aws_eip.openvpn.public_dns
    private_ip  = aws_instance.openvpn.private_ip
    private_dns = aws_instance.openvpn.private_dns
  }
}

output "private_instance" {
  value = {
    public_ip   = aws_instance.private.public_ip
    public_dns  = aws_instance.private.public_dns
    private_ip  = aws_instance.private.private_ip
    private_dns = aws_instance.private.private_dns
  }
}
