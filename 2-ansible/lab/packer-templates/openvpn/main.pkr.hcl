build {
  name = "aws"

  sources = [
    "amazon-ebs.ubuntu",
  ]

  provisioner "shell" {
    inline = [
      "mkdir -m 755 -p /opt/ansible",
      "chown -R ubuntu:ubuntu /opt/ansible",
      "cloud-init status --wait",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  provisioner "ansible" {
    playbook_file = "${path.root}/ansible/initialize.yaml"
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False",
    ]
    ansible_ssh_extra_args = [
      "-o ForwardAgent=yes",
    ]
    user = "ubuntu"
  }

  provisioner "ansible-local" {
    playbook_file = "${path.root}/ansible/playbook.yaml"
    staging_directory = "/opt/ansible/"
    clean_staging_directory = false
  }

  post-processor "manifest" {
    output     = "packer-manifest.json"
    strip_path = true
  }
}
