# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Базовый образ (Ubuntu 20.04 LTS)
  config.vm.box = "ubuntu/focal64"

  # Отключаем автоматическую замену SSH-ключей (повышает стабильность)
  config.ssh.insert_key = false

  # Приватная сеть с фиксированным IP
  config.vm.network "private_network", ip: "192.168.56.11"

  # Явный проброс SSH-порта
  config.vm.network "forwarded_port", guest: 22, host: 2223,
    id: "ssh", auto_correct: true

  # Настройки VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.name = "zabbix-vm"
    vb.memory = "3072"
    vb.cpus = 2
  end

  # Настройки vagrant-vbguest (автообновление гостевых дополнений)
  config.vbguest.auto_update = true
  config.vbguest.no_install = false
  config.vbguest.no_remote = false
  config.vbguest.auto_reboot = true
  # Явно указываем источник ISO (можно закомментировать, если доверяете автоматике)
  config.vbguest.iso_path = "https://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"

  # Провижинер для обновления системы и установки необходимых пакетов
  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get -y dist-upgrade 
    # Устанавливаем метапакет заголовков ядра (всегда под актуальное ядро) и инструменты сборки
    apt-get install -y linux-headers-generic build-essential python3 python3-pip
  SHELL

  # Провижинер Ansible (запускается внутри гостевой системы)
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "vv"
  end
end