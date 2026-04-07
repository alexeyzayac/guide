# 99_inventory_for_ansible.tf

resource "local_file" "inventory" {
  content = <<-INI
[docker]
${yandex_compute_instance.vm-docker-test.name} ansible_host=${yandex_compute_instance.vm-docker-test.network_interface[0].nat_ip_address}


[all:vars]
ansible_user=localadmin
ansible_ssh_private_key_file=../ssh/cloud-${var.flow}
ansible_python_interpreter=/usr/bin/python3
  INI
  filename = "../ansible/inventory.ini"
}