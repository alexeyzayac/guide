## Клонирование в GIT

### Стандартное клонирование:
```bash
git clone https://github.com/alexeyzayac/devops-netology.git
```
### Загрузить все удалённые ветки:
```bash
git fetch --all
```

### Создать локальные ветки для  удалённой:
#### Переключиться на нужную ветку (Git сам создаст локальную копию):
```bash
git checkout название_ветки
```

#### Создать локальные ветки для всех удалённых сразу:
```bash
for branch in $(git branch -r | grep -v HEAD); do 
    git branch --track ${branch#origin/} $branch
done
```
#### Полное зеркало, но без рабочего каталога:
```bash
git clone --mirror https://github.com/alexeyzayac/devops-netology.git
```
