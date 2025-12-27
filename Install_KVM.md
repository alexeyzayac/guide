# Установка и настройка VirtualBox

## 1. Базовые пакеты (обязательно).
#### Установка:

````bash
apt install -y \
  qemu-kvm \                    # сам гипервизор
  libvirt-daemon-system \       # управляющий слой
  libvirt-clients \             # управляющий слой
  virtinst \                    # создание ВМ из CLI
  virt-manager \                # GUI (удобно даже на сервере по X11)
  bridge-utils \                # сети
  cpu-checker                   # проверка KVM
````

#### Проверка:

````bash
kvm-ok
````

#### Ожидаемый результат:

````bash
INFO: /dev/kvm exists
KVM acceleration can be used
````

---

## 2. Подготовка и запуск libvirt.

#### Запуск:

````bash
systemctl enable --now libvirtd
````
#### Доступ пользователю:

````bash
usermod -aG libvirt $USER
usermod -aG kvm $USER
````

---

## 3. Пример создания ВМ:

### Использование через CLI:

````bash
virt-install \
  --name test-vm \
  --ram 2048 \
  --vcpus 2 \
  --disk path=/var/lib/libvirt/images/test.qcow2,size=20 \
  --os-variant ubuntu22.04 \
  --cdrom /iso/ubuntu-22.04.iso \
  --graphics spice
````

### Если используешь Vagrant + KVM:

#### Убедиться, что установлен плагин:

````bash
vagrant plugin install vagrant-libvirt
````

#### Vagrantfile:

````bash
Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 2048
    libvirt.cpus = 2
  end
end
````

#### Запуск:

````bash
vagrant up --provider=libvirt
````