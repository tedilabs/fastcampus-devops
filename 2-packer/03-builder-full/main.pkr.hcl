build {
  name    = "fastcampus-packer"

  source "amazon-ebs.ubuntu" {
    name     = "vault"
    ami_name = "fastcampus-packer-vault"
  }

  source "amazon-ebs.ubuntu" {
    name     = "consul"
    ami_name = "fastcampus-packer-consul"
  }

  provisioner "shell" {
    inline = [
      "echo Hello World!"
    ]
  }

  provisioner "shell" {
    inline = [
      "echo Next World!"
    ]
  }

  post-processor "shell-local" {
    inline = [
      "echo Hello World!"
    ]
  }

  post-processor "shell-local" {
    inline = [
      "echo Next World!"
    ]
  }
}
