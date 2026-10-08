# minikube

## Основа

### Основные команды

```bash
# Узнать версию
minikube version

# Состояние нод в кластере
minikube status -p zayac

# Посмотреть список всех созданных кластеров (профилей)
minikube profile list

# Переключиться на другой кластер
minikube profile my-other-cluster

# Проверить наличие обновлений для minikube
minikube update-check
```

## Создание кластера

### Кластеры в virtualbox
```bash
# Создание кластера zayac
minikube start --driver=virtualbox \
  --cpus=4 --memory=4gb --disk-size=20gb \
  -p zayac

# Создание кластера zayac с установленным плагином Calico
minikube start --driver=virtualbox \
  --cpus=4 --memory=4gb --disk-size=20gb \
  -p zayac --cni=calico

# Создание кластера zayac из 3 узлов (--nodes=3 это 1 мастер + 2 воркера) 
minikube start --driver=virtualbox \
  --cpus=4 --memory=4gb --disk-size=20gb \
  --nodes=3 \
  -p zayac

# Создание кластера zayac из 3 узлов (--nodes=3 это 1 мастер + 2 воркера) 
minikube start --driver=virtualbox \
  --cpus=4 --memory=4gb --disk-size=20gb \
  --nodes=3 \
  -p zayac

# Создание кластера с 3 мастерами и 2 воркерами (--ha включает режим высокой доступности)
minikube start --driver=virtualbox \
  --cpus=4 --memory=4gb --disk-size=20gb \
  --nodes=5 --ha \
  -p zayac
```

### Создание нод
```bash
# Добавить воркер к существующему кластеру
minikube node add -p zayac # повторный ввод +1 нода

# Добавить воркер к существующему кластеру с именем вручную (имя как аргумент)
minikube node add my-worker-1 -p zayac

# Добавить воркер к существующему кластеру с именем вручную (через флаг --name)
minikube node add --name my-worker-2 -p zayac

# Добавить ещё 1 мастера (только для кастеров с флагом --ha)
minikube node add --control-plane -p zayac 
```

## Работа с кластером

### Управение кластером

```bash
# Остановить кластер (состояние сохраняется)
minikube stop -p zayac

# Запустить кластер
minikube start -p zayac

# Удалить кластер и все связанные с ним файлы
minikube delete -p zayac

# Удалить все кластеры и профили, включая папку .minikube
minikube delete --all --purge
```

### Управление узлами и доступ к ним

```bash
# Посмотреть список узлов с их IP-адресами
minikube node list -p zayac

# Получить IP-адрес основного узла (control-plane)
minikube ip -p zayac

# Получить IP-адрес конкретного узла
minikube ip -n zayac-m02 -p zayac

# Зайти по SSH на основной узел для отладки
minikube ssh -p zayac

# Выполнить команду на конкретном узле
minikube -p zayac ssh -n zayac-m02 -- "sudo journalctl -u kubelet -n 50"

# Получить путь к SSH-ключу для узла
minikube ssh-key -p zayac

# Получить SSH host key узла (полезно для добавления в known_hosts)
minikube ssh-host --append-known -p zayac
```

### Работа с аддонами

```bash
# Посмотреть список всех доступных и включенных аддонов
minikube addons list -p zayac

# Включить аддон (например, dashboard для веб-интерфейса)
minikube addons enable dashboard -p zayac

# Включить ingress-контроллер (необходим для внешнего доступа к сервисам)
minikube addons enable ingress -p zayac

# Включить metrics-server (для работы команд `kubectl top`)
minikube addons enable metrics-server -p zayac

# Отключить аддон
minikube addons disable dashboard -p zayac

# Включить аддон сразу при старте кластера
minikube start --addons=dashboard,ingress --addons=metrics-server -p zayac
```