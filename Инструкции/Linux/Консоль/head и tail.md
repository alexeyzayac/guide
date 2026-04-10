```bash
#вывод 10 строк первых (по умолчанию)
head /etc/passwd

#вывод 10 строк последних (по умолчанию)
tail /etc/passwd

# tail (-n) вывод последних 3 строк
tail -n 3 /etc/passwd

# tail (-n+) вывод всех строк начиная с 35
tail -n+35 /etc/passwd

#вывод только 4 строчки
head -n4 /etc/passwd | tail -n1

#вывод строк с 6 по 8
head -n8 /etc/passwd | tail -n3
```

Данные команды поддерживаю более простой синтаксис для указания количества строк без параметра -n.
```bash
#вывод 5 строк первых
head -5 /etc/passwd

#вывод 5 строк последних
tail -5 /etc/passwd

#вывод всех строк начиная с 35
tail +35 /etc/passwd

#вывод только 36 строчки
tail +36 /etc/passwd | head -1
```