## 0. Базовые пакеты для сборки модулей ядра (обязательно)
#### Установка:

````bash
apt install -y \
  dkms \
  build-essential \
  linux-headers-$(uname -r) \
  ca-certificates \
  wget \
  gnupg
````

#### Проверка:

````bash
ls /lib/modules/$(uname -r)/build
````

---

## 1. Установка VirtualBox (официальный репозиторий Oracle).
#### Ключ VirtualBox:

````bash
wget -qO- https://www.virtualbox.org/download/oracle_vbox_2016.asc \
  | gpg --dearmor \
  | tee /usr/share/keyrings/oracle-virtualbox.gpg >/dev/null
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

#### Cобрать и установить модули:

````bash
/sbin/vboxconfig           
systemctl restart vboxdrv
systemctl status vboxdrv --no-pager
VBoxManage --version
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

### Плагины Vagrant (обязательно).
#### синхронизация Guest Additions:

````bash
vagrant plugin install vagrant-vbguest
````

#### перезагрузка без проблем:

````bash
vagrant plugin install vagrant-reload
````