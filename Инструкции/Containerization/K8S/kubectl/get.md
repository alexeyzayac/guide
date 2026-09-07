# kubectl get

### `kubectl get` служит для получения информации о любых ресурсах кластера. Основное окно для просмотра состояния приложений, узлов и других объектов.

Базовая структура команды выглядит так:
```bash
kubectl get [RESOURCE] [NAME] [flags]
```

---

### Что можно получить?

| Ресурс             | Команда                                  |
|--------------------|------------------------------------------|
| Поды               | `kubectl get pods`                       |
| Узлы	             | `kubectl get nodes`                      |
| Сервисы            | `kubectl get services`                   |
| Деплойменты        | `kubectl get deployments`                |
| ReplicaSets        | `kubectl get replicasets`                |
| ConfigMap / Secret | `kubectl get configmaps / secrets`       |
| PersistentVolumes  | `kubectl get pv`                         |
| Namespaces	     | `kubectl get ns`                         |
| Все ресурсы в NS   | `kubectl get all`(ограниченный набор)    |
| Любой CRD	         | `kubectl get <crd-name>`                 |

* `kubectl get all` не показывает все ресурсы (например, ConfigMap, Secret, Ingress). 
* Для полного списка используйте `kubectl api-resources`.

#### Просмотр сразу нескольких типов:
```bash
kubectl get pods,services,deployments
```

---

### Форматы вывода:

| Формат	                | Опция	                | Пример
|---------------------------|-----------------------|-----------------------------------------------------------------------------------|
| Широкий (больше колонок)  | -o wide               | `kubectl get pods -o wide` (IP, нода, и т.д.)                                     |
| YAML                      | -o yaml               | `kubectl get pod hello -o yaml`                                                   |
| JSON                      | -o json               | `kubectl get pod hello -o json `                                                  |
| Только имена	            | -o name	            | `kubectl get pods -o name → pod/hello`                                            |
| Custom columns            | -o custom-columns=... | `kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase`     |
| JSONPath                  | -o jsonpath='{...}'   | `kubectl get pods -o jsonpath='{.items[*].metadata.name}'`                        |
| Шаблон Go	                | -o go-template=...    | редко, но есть                                                                    |

```bash
# Широкий вывод подов
kubectl get pods -o wide

# Получить все pod-ы в виде YAML
kubectl get pods -o yaml

# Только имена подов
kubectl get pods -o name

# Свои колонки: имя, образ, статус
kubectl get pods -o custom-columns=NAME:.metadata.name,IMAGE:.spec.containers[*].image,STATUS:.status.phase
```

---

### Фильтрация:

#### Отслеживание изменений `-w`
```bash
# Следить за изменениями подов в реальном времени
kubectl get pods -w
```

#### По меткам `-l`:
```bash
# Поды с меткой app=web
kubectl get pods -l app=web

# Поды с меткой app в значении web или api
kubectl get pods -l 'app in (web, api)'

# Поды без метки app
kubectl get pods -l '!app'
```

#### По полям `--field-selector`:
```bash
# Поды с определённым статусом
kubectl get pods --field-selector status.phase=Running

# Поды на конкретной ноде
kubectl get pods --field-selector spec.nodeName=node-1

# Комбинируем с метками
kubectl get pods -l app=web --field-selector status.phase=Running
```

### По полям `--sort-by`
```bash
# По времени создания (от новых к старым)
kubectl get pods --sort-by=.metadata.creationTimestamp

# По имени
kubectl get pods --sort-by=.metadata.name

# По использованию CPU (требует metrics-server)
kubectl get pods --sort-by=.spec.containers[0].resources.requests.cpu
```

---

### Дополнительные опции:

| Флаг	                | Назначение                                        |
|-----------------------|---------------------------------------------------|
| --show-labels         | Показать все метки в отдельной колонке            |
| -L <label-key>        | Добавить колонку со значением указанной метки     |
| --chunk-size=500      | Для больших кластеров — пагинация запросов        |
| --ignore-not-found    | Не выдавать ошибку, если объект не найден         |

```bash
# Показать поды с колонкой версии приложения (метка version)
kubectl get pods -L version

# Показать все метки
kubectl get pods --show-labels
```

---

### Комбинированные примеры:
```bash
# Все поды в namespace app с меткой env=prod, отсортированные по времени
kubectl -n app get pods -l env=prod --sort-by=.metadata.creationTimestamp

# Широкий вывод с добавлением колонки node
kubectl get pods -o wide -L node

# Получить IP всех подов в JSONPath (для скриптов)
kubectl get pods -o jsonpath='{range .items[*]}{.status.podIP}{"\n"}{end}'

# Количество подов в каждом статусе
kubectl get pods --no-headers | awk '{print $3}' | sort | uniq -c
```

---