# Команда find

## Рекурсивный поис 
```bash
$ find /etc -print | tail -n 5 # Рекурсивный вывод всех файлов и подкаталогов в /etc
/etc/perl/Net/libnet.cfg
/etc/sysctl.d
/etc/sysctl.d/README.sysctl
/etc/python3.13
/etc/python3.13/sitecustomize.py
```

```bash
$ find /etc -type f -print | tail -n 5 # Список всех файлов в /etc рекурсивно
/etc/login.defs
/etc/hosts
/etc/perl/Net/libnet.cfg
/etc/sysctl.d/README.sysctl
/etc/python3.13/sitecustomize.py
```

```bash
$ find /etc -type d -print | tail -n 5 # Список всех директориев в /etc рекурсивно
/etc/profile.d
/etc/perl
/etc/perl/Net
/etc/sysctl.d
/etc/python3.13
```

```bash
$ find /etc -type f -name "*.conf" -print | tail -n 5 # Список всех файлов в /etc заканчивающихся на .conf
/etc/cups/printers.conf
/etc/cups/subscriptions.conf
/etc/cups/cupsd.conf
/etc/cups/cups-files.conf
/etc/gai.conf
```

```bash
$ find . -iname "*.txt" -print # Поис не чувствительный к регистру
./2.txt
./3.TxT
./1.txt `
```

```bash
find . -type f \( -name "*.pdf" -o -name "*.html" \) | head -n 2 # Поиск файлов двух типов одновременно
./usr/lib/ruby/gems/3.3.0/gems/racc-1.7.3/doc/ja/index.ja.html
./usr/lib/python3/dist-packages/ansible_collections/cisco/intersight/misc/CL2020 EMEAR DEVWKS-1542 Intersight Ansible Lab Guide.pdf
```

## exec

```bash
$ find . -iname "*.txt" -exec echo @ {} @ ";" # Поис не чувствительный к регистру с выводом через echo @ {} @
@ ./2.txt @
@ ./3.TxT @
@ ./1.txt @
```

```bash
$ find . -type f \( -name "*.pdf" -o -name "*.html" \) -exec echo rm {} ";" # Поиск файлов двух типов одновременно и подготовка к удалению
rm ./Progit.pdf
rm ./bookmarks_02.04.2026.html

-o # логическое ИЛИ
```

```bash
$ find . -type f \( -name "*.pdf" -o -name "*.html" \) -exec rm {} ";" # Удаление найденных файлов .pdf и .html
```

## find не работает с алиасами (ll — алиас, ls -l — настоящая команда)
```bash
$ find . -type f -name "*.txt" -exec ll {} ";" 
find: ‘ll’: Нет такого файла или каталога
$ find . -type f -name "*.txt" -exec ls -l {} ";"
-rw-rw-r-- 1 user-host user-host 0 апр  2 17:45 ./2.txt
-rw-rw-r-- 1 user-host user-host 0 апр  2 17:45 ./1.txt
```

## Поиск по размеру файла
```bash
# Поиск по весу (G, M, k, 0)
$ find . -type f -size +1G | head -n 1 # Поиск файлов больше 1gb.
./home/user-host/VirtualBox VMs/nginx-vm/ubuntu-focal-20.04-cloudimg.vmdk
```

```bash
$ find . -type f -size -1k | head -n 1 # Поиск файлов меньше 1kb.
./usr/src/linux-headers-6.12.69+deb13-amd64/include/config/DS1682
```

## Поиск по времени изменения (модификации)
```bash
$  find . -type f -mtime -7 | head -n 1 # изменённые за последние 7 дней
./usr/lib/x86_64-linux-gnu/vlc/plugins/plugins.dat
```

```bash
$  find . -type f -mtime +30 | head -n 1 # не менявшиеся более 30 дней
./usr/src/linux-headers-6.12.73+deb13-common/include/keys/asymmetric-parser.h
```

```bash
$  find . -type f -mmin -30 | head -n 1 # изменённые за последние 30 минут
./proc/irq/124/node
```

## Поиск и удаление
```bash
$  find . -name "*.tmp" -delete # Находит и удаляет все файлы с расширением .tmp внутри текущей директории (и всех её поддиректориях).
$  find . -type f -empty -delete # Находит и удаляет только обычные файлы, которые имеют нулевой размер (пустые), внутри текущей директории и её поддиректорий.

-delete # удалить найденные объекты
-empty # файл пуст (размер 0 байт) или директория не содержит элементов.
```

## Исключить каталог из поиска
```bash
find . -path ./home -prune -o -name "*.js" -print | head -n 2
./usr/lib/ruby/3.3.0/rdoc/generator/template/darkfish/js/darkfish.js
./usr/lib/ruby/3.3.0/rdoc/generator/template/darkfish/js/search.js
```