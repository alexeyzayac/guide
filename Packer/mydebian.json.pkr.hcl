source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "*****************",
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "*****************",
  token               = "*****************",
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "sudo sed -i '/bullseye-backports/s/^/#/' /etc/apt/sources.list || true",
      "sudo apt-get update",
      "sudo apt-get install -y ca-certificates curl",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc",
      "sudo chmod a+r /etc/apt/keyrings/docker.asc",
      "sudo tee /etc/apt/sources.list.d/docker.sources <<EOF\nTypes: deb\nURIs: https://download.docker.com/linux/debian\nSuites: $(. /etc/os-release && echo \"$VERSION_CODENAME\")\nComponents: stable\nSigned-By: /etc/apt/keyrings/docker.asc\nEOF\n",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "sudo apt-get install -y htop tmux",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo docker run hello-world || true",
      "sudo apt full-upgrade -y",
      "sudo apt autoremove -y",
      "sudo apt purge ~c -y",
      "echo 'hello from packer'"
    ]
  }
}