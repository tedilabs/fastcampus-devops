data "amazon-secretsmanager" "fastcampus" {
  name = "fastcampus"
  key  = "test"
}

build {
  name    = "fastcampus-packer"

  source "amazon-ebs.ubuntu" {
    name     = "nginx"
    ami_name = "fastcampus-packer-nginx"
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "echo Secret is ${data.amazon-secretsmanager.fastcampus.value}",
    ]
  }

  provisioner "file" {
    source      = "${path.root}/files/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "shell" {
    inline = [
      "echo ${source.name} and ${source.type}",
      "whoami",
      "sudo apt-get install -y nginx",
      "sudo cp /tmp/index.html /var/www/html/index.html"
    ]
  }
}
