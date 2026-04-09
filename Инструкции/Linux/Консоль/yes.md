# Команда yes

##    Бесконечно выводит заданную строку
```bash
$ yes # выводит "y", остановить с помощью ctrl+c
y
y ^c
```
```bash
$ yes PRM # повторяет любую другую строку
PRM
PRM ^c
```
## Основное применение — автоматический положительный ответ
```bash
$ yes | rm -i *.txt # удаление всех .txt файлов с подтверждением каждого
rm: удалить regular empty file '1.txt'? rm: удалить regular empty file '2.txt'? rm: удалить regular empty file '3.txt'? rm: удалить regular empty file '4.txt'?
```
## Установка пакета в дистрибутиве на базе Debian
```bash
$ yes | sudo apt install python3 # автоматически проставляет yes
```
## Генерация большого файла для тестов
```bash
$ yes "abc" | head -n 5000 | tee test{1..5}.txt > /dev/null # Создаётся 5 файлов с 5000 строк abc
```
## Сброс кеша или проверка стабильности системы
```bash
yes > /dev/null &   # запускает yes в фоне, вывод уходит в "чёрную дыру"
```