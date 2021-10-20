build {
  name    = "fastcampus-packer"

  source "amazon-ebs.ubuntu" {
    name     = "nginx"
    ami_name = "fastcampus-packer"
  }

  post-processor "manifest" {}

  post-processors {
    post-processor "shell-local" {
      inline = ["echo Hello World! > artifact.txt"]
    }
    post-processor "artifice" {
      files = ["artifact.txt"]
    }
    post-processor "compress" {}
  }

  post-processors {
    post-processor "shell-local" {
      inline = ["echo Finished!"]
    }
  }
}
