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