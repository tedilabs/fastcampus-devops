output "demo_instance" {
  value = {
    public_ip   = aws_instance.demo.public_ip
    public_dns  = aws_instance.demo.public_dns
    private_ip  = aws_instance.demo.private_ip
    private_dns = aws_instance.demo.private_dns
  }
}
