output "openvpn_instance" {
  value = {
    public_ip   = aws_eip.openvpn.public_ip
    public_dns  = aws_eip.openvpn.public_dns
    private_ip  = aws_instance.openvpn.private_ip
    private_dns = aws_instance.openvpn.private_dns
  }
}

output "grafana_instance" {
  value = {
    public_ip   = aws_instance.grafana.public_ip
    public_dns  = aws_instance.grafana.public_dns
    private_ip  = aws_instance.grafana.private_ip
    private_dns = aws_instance.grafana.private_dns
  }
}
