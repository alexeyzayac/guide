### Команда rev
Основная задача переворачивать символ задом на перёд

```bash
# Переворачивае задом на перёд
$ echo "Hello World" | rev
dlroW olleH

# Сложный вывод (удобно когда например надо вывести последнее слово из строки, но длина полей отличается)
$ df -h -x tmpfs | rev | cut -d " " -f1 | rev | tail +2
/sys/firmware/efi/efivars
/boot
/boot/efi

# Удобно для чтения логов
$ echo "error:404:not found:file.txt" | rev | cut -d':' -f1 | rev
file.txt
```