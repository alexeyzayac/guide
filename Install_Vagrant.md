# Установка и настройка Vagrant

## 1. Базовые пакеты для сборки модулей ядра (обязательно).
#### Установка:

````bash
apt install -y \
  dkms \
  build-essential \
  linux-headers-$(uname -r) \
  libvirt-dev \
  libvirt-daemon-system \
  libvirt-clients \
  pkg-config \
  ruby-dev \
  gcc make
````

#### Проверка:

````bash
ls /lib/modules/$(uname -r)/build
````

---

## 2. Установка Vagrant (HashiCorp repo).
#### Ключ HashiCorp:

````bash
wget -qO- https://apt.releases.hashicorp.com/gpg \
  | gpg --dearmor \
  | tee /usr/share/keyrings/hashicorp.gpg >/dev/null
````

#### Добавление репозитория:

````bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp.gpg] \
https://apt.releases.hashicorp.com trixie main" \
| tee /etc/apt/sources.list.d/hashicorp.list
````

#### Установка:

````bash
apt update
apt install -y vagrant
vagrant --version
````

## 2. Плагины Vagrant (обязательно).
#### Синхронизация Guest Additions:

````bash
vagrant plugin install vagrant-vbguest
````

#### Перезагрузка без проблем:

````bash
vagrant plugin install vagrant-reload
````

#### Позволяет Vagrant работать с KVM / libvirt.

````bash
vagrant plugin install vagrant-libvirt
````

#### Проверка плагинов.

````bash
vagrant plugin list
````

#### Рекомендация, это лечит 90% странных конфликтов Ruby-зависимостей.

````bash
vagrant plugin expunge --reinstall
````

---

## 3. Режимы работы Vagrant.

### Режим 1: Vagrant + VirtualBox.

````bash
sudo systemctl start vboxdrv.service
sudo systemctl stop libvirtd 
sudo systemctl stop libvirtd.socket
sudo modprobe -r kvm_intel 
sudo modprobe -r kvm_amd
sudo modprobe -r kvm
````

#### Проверка, при выводе должно быть пусто.

````bash
lsmod | grep kvm
````

### Режим 2: KVM / libvirt / k8s / minikube.

````bash
sudo systemctl stop vboxdrv.service
sudo modprobe -r vboxdrv
sudo modprobe kvm 
sudo modprobe kvm_intel
sudo systemctl start libvirtd
````

#### Проверка, при выводе должно быть пусто.

````bash
lsmod | grep kvm
virsh list --all
````

#### Добавь пользователя в группу (один раз).

````bash
sudo usermod -aG libvirt $USER
newgrp libvirt
````