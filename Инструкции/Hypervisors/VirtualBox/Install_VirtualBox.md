# Установка и настройка VirtualBox

## 1. Базовые пакеты для сборки модулей ядра (обязательно).
#### Установка:

````bash
apt install -y \
  dkms \
  build-essential \
  linux-headers-$(uname -r) \
  ca-certificates \
  wget \
  gnupg \
  lsb-release
````

#### Проверка:

````bash
ls /lib/modules/$(uname -r)/build
````

---

## 2. Установка VirtualBox (официальный репозиторий Oracle).
#### Ключ VirtualBox:

````bash
wget -qO- https://www.virtualbox.org/download/oracle_vbox_2016.asc \
  | gpg --dearmor \
  | tee /usr/share/keyrings/oracle_vbox.gpg >/dev/null
````

#### Добавление репозитория:

````bash
echo "deb [signed-by=/usr/share/keyrings/oracle_vbox.gpg arch=amd64] https://download.virtualbox.org/virtualbox/debian trixie contrib" \
  | tee /etc/apt/sources.list.d/virtualbox.list
````

#### Установка:

````bash
apt update
apt install -y virtualbox-7.1
````

#### Проверка, что пакеты видны:

````bash
apt-cache policy virtualbox-7.1
````

#### Сборка и установка модулей:

````bash
/sbin/vboxconfig           
systemctl restart vboxdrv
systemctl status vboxdrv --no-pager
VBoxManage --version
````