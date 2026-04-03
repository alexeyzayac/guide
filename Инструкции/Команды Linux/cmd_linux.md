### Команда date

```bash
date
Ср 01 апр 2026 15:59:28 MSK

date +%Y:%m:%d
2026:04:01

date +%D
04/01/26

date +%H:%M:%S
16:03:03

date +%Z
MSK
```

---

### Команда seq

```bash
seq 1 5
1
2
3
4
5

seq 1 0.5 2
1,0
1,5
2,0

seq -s/ 1 5
1/2/3/4/5

seq -s: 2 4 12
2:6:10

seq -w 1 4 10
01
05
09
```

---

### Команда echo

```bash
echo {10..01}
10 09 08 07 06 05 04 03 02 01k

echo {1..1000..100}
1 101 201 301 401 501 601 701 801 901

echo {01..1000..100}
0001 0101 0201 0301 0401 0501 0601 0701 0801 0901

echo {A..Z}
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
```

---

### Команда tr

```bash
echo {A..Z} | tr -d " "
ABCDEFGHIJKLMNOPQRSTUVWXYZ

echo {A..D} | tr " " "\n"
A
B
C
D
```

---

### Команда ls

```bash
alias ll
alias ll='ls -AlhF --color'

ll
итого 0
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file2
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file3
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file4
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file5
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file7

ll file[2..7]
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file2
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file7

ll file[2-7]
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file2
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file3
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file4
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file5
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file7

ll file{2..7}
ls: невозможно получить доступ к 'file6': Нет такого файла или каталога
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file2
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file3
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file4
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file5
-rw-rw-r-- 1 user-host user-host 0 апр  1 17:37 file7


ll file{2-7}
ls: невозможно получить доступ к 'file{2-7}': Нет такого файла или каталога
 ```