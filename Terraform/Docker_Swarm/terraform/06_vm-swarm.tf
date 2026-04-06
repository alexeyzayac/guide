# 05_vm-netology.tf

# vm-swarm-manager
resource "yandex_compute_instance" "vm-swarm-manager" {
  name        = "vm-swarm-manager"
  hostname    = "vm-swarm-manager"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.toolbox.image_id
      type     = "network-hdd"
      size     = 30
    }
  }

  metadata = {
    user-data = templatefile("../cloud-init/cloud-init.tpl", {
      public_key = tls_private_key.ssh.public_key_openssh
    })
    serial-port-enable = 1
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet_a.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.cluster_sg.id]
  }
}

# vm-node-worker-1
resource "yandex_compute_instance" "vm-node-worker-1" {
  name        = "vm-node-worker-1"
  hostname    = "vm-node-worker-1"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.toolbox.image_id
      type     = "network-hdd"
      size     = 30
    }
  }

  metadata = {
    user-data = templatefile("../cloud-init/cloud-init.tpl", {
      public_key = tls_private_key.ssh.public_key_openssh
    })
    serial-port-enable = 1
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet_a.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.cluster_sg.id]
  }
}

# vm-node-worker-2
resource "yandex_compute_instance" "vm-node-worker-2" {
  name        = "vm-node-worker-2"
  hostname    = "vm-node-worker-2"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.toolbox.image_id
      type     = "network-hdd"
      size     = 30
    }
  }

  metadata = {
    user-data = templatefile("../cloud-init/cloud-init.tpl", {
      public_key = tls_private_key.ssh.public_key_openssh
    })
    serial-port-enable = 1
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet_a.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.cluster_sg.id]
  }
}