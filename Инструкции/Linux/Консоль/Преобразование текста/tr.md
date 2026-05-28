### Команда tr
Основная задача переводить один набор символов в другой

```bash
# Команда меняет <Пробел>, на начало новой строки
$ echo {A..D} | tr " " "\n"
A
B
C
D

# Команда удаляет символ <Пробел>
$ echo {A..Z} | tr -d " "
ABCDEFGHIJKLMNOPQRSTUVWXYZ

# Команда меняет символ <:>, на начало новой строки
$ echo $PATH | tr : "\n"
/usr/local/bin
/usr/bin
/bin
/usr/local/games
/usr/games

#  Преобразование нижнего регистра в верхний
$ echo "Hello World" | tr a-z A-Z
$ echo "Hello World" | tr [:lower:] [:upper:]
HELLO WORLD 

# Убирает повторы из последовательности одинаковых символов, заменяя их одним
echo "a::::::::::b::::::c:d" | tr -s ':' 
a:b:c:d
```