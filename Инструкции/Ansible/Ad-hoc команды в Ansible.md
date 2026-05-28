>**Ad-hoc команды в Ansible** — это одноразовые команды для быстрого выполнения отдельных задач на удалённых серверах, которые не нужно сохранять для последующего использования

##### Структура использования:
```bash
ansible <шаблон_хостов> -m <имя_модуля> -a "<аргументы_модуля>"
```
### Примеры использования:
**1. Проверка доступности хостов:**
```bash
ansible all -m ping
```

**2. Выполнение команд через модуль `command`:**
```bash
ansible all -m command -a uptime
ansible all -a uptime
ansible all -a "tail /var/log/dmesg"
```
>*П.С.: если `-m` опущен, Ansible по умолчанию использует модуль `command`*

**3. Гибкое выполнение команд (модуль `shell`)**
```bash
ansible all -m shell -a "ls -lA /home/user/"
```

**4. Команды с повышением привилегий (`-b` / `--become`)**
```bash
ansible all -b -a "tail /var/log/syslog"
```

**5. Копирование файлов (модуль `copy`)**
```bash
ansible all -m copy -a "src=test.txt dest=/home/user/ mode=777"
```

 **6. Управление файлами и каталогами (модуль `file`)**
```bash
ansible all -m file -a "path=/home/user/test.txt state=absent"
```

**7. Скачивание файлов из интернета (модуль `get_url`)**
```bash
ansible all -m get_url -a "url= dest=/home/user"
```

**8. Выполнение HTTP-запросов (модуль `uri`)**
```bash
ansible all -m uri -a "url= return_content=yes"
```
>*П.С.: `return_content=yes` добавляет тело ответа в вывод Ansible*

**9. Управление пакетами (модуль `package`)**
```bash
ansible all -b -m package -a name=tree
ansible all -b -m package -a "name=nginx update_cache=yes"
ansible all -b -m package -a "name=nginx state=absent"
```

**10. Управление сервисами (модуль `service`)**
```bash
ansible all -b -m service -a "name=nginx state=restarted"
```
