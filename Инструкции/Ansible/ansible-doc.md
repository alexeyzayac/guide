**Официальная документация ([docs.ansible.com](https://docs.ansible.com/))**

**`1. ansible-doc -l`**
>Просмотр спиcка всех установленных модулей с краткими описаниями
```bash
ansible-doc -l
ansible-doc -l | grep -i docker
ansible-doc -l community.docker
```
---
**`2. ansible-doc <module>`**
> Детальная документация по конкретному модулю (параметры, примеры, возвращаемые значения).
```bash
ansible-doc copy
ansible-doc file
```
---
**3. `ansible-doc -s`**
>**сокращённый вывод**: только синтаксис и ключевые параметры, без подробных описаний
```bash
ansible-doc -s file
ansible-doc -s authorized_key
```
---
 **4. `ansible-doc -t type -l`**
>фильтрация **по типу плагина**: `module`, `lookup`, `callback`, `inventory`, `filter` и др.
```bash
ansible-doc -t inventory -l
ansible-doc -t vars -l
```