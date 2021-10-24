build {
  name = "aws"

  sources = [
    "amazon-ebs.ubuntu",
  ]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  provisioner "file" {
    source      = "${path.root}/files/run-docker-openvpn.sh"
    destination = "/tmp/run-docker-openvpn.sh"
  }

  provisioner "shell" {
    inline = [
      "mkdir -p /opt/openvpn",
      "cp /tmp/run-docker-openvpn.sh /opt/openvpn/run-docker-openvpn.sh"
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/scripts/update-apt.sh",
      "${path.root}/scripts/install-common-tools.sh",
      "${path.root}/scripts/configure-locale.sh",
      "${path.root}/scripts/install-docker.sh",
      "${path.root}/scripts/clean-apt.sh",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  post-processor "manifest" {
    output     = "dist/packer-manifest.json"
    strip_path = true
  }
}
