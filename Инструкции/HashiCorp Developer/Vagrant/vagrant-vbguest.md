
































# 1. Удалить сломанный плагин





















vagrant plugin uninstall vagrant-vbguest

# 2. Клонировать форк с исправлением
git clone https://github.com/dheerapat/vagrant-vbguest.git
cd vagrant-vbguest

# 3. Собрать и установить
gem build vagrant-vbguest.gemspec
vagrant plugin install ./vagrant-vbguest-*.gem

#### После установки **НИ В КОЕМ СЛУЧАЕ не запускайте** `vagrant plugin update` — он перезапишет исправленную версию на официальную сломанную.