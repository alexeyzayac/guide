## Базовые команды
```bash
#печать каждого второго слова
awk '{print $2}' /etc/hosts

#если вывод требуется столбца из двух цифр, то берётся в скобки
awk '{print $(25)}' /path/to/file

#вывод всей строки $0
awk '{print $0}' /etc/hosts

#вывод посленей строки $NF
awk '{print $NF}' /etc/hosts
```
awk по умолчанию не умеет печатать пробелы между значениями:
```bash
echo Hello World Astra | awk '{print $1$3}'
HelloAstra

#необходимо разделить запятой
echo Hello World Astra | awk '{print $1, $3}'
Hello Astra
```
awk работает с отработкой вывода команд:
```bash
df -Ht ext4 --total | awk '{print $1, $2}'

#если нужно не выводить первую строку
df -Ht ext4 --total | awk 'FNR>1 {print $1, $2}'

#или убрать всё начиная со 2 строки
df -Ht ext4 --total | awk 'FNR<2 {print $1, $2}'
```
Если вывод разделен чем-то другим, кроме пробелов, можно разделить:
```bash
cat /etc/passwd | awk -F':*' '{print $1, $6}'
```