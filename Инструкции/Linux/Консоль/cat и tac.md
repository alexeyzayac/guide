cat выводит построчно текст
```bash
cat /etc/passwd
```
tac переворачивает текст и выводит
```bash
tac /etc/passwd
```
```bash
#Создать файл одной командой
cat > hello.sh << EOF
#!/bin/bash
echo "hi"
EOF
```