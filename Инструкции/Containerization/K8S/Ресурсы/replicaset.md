# ReplicaSet в Kubernetes

> `ReplicaSet` — контроллер, который поддерживает заданное количество реплик Pod.
* Cледит, чтобы в кластере всегда было ровно N подов, соответствующих его селектору. Если под упал — создаёт новый. Если подов больше — удаляет лишние.

## Базовые команды

```bash
# Посмотреть ReplicaSet в текущем namespace
kubectl get replicasets
kubectl get rs

# В конкретном namespace
kubectl -n app get replicasets

# Во всех namespace
kubectl get replicasets -A

# С метками и широким выводом
kubectl get rs --show-labels
kubectl get rs -o wide

# Описать
kubectl describe rs my-rs
kubectl -n app describe rs my-rs
```

> ❗ `describe` не поддерживает `--all-namespaces`

## Создать ReplicaSet

```bash
# Создаст Deployment, а не ReplicaSet
kubectl create deployment web --image=nginx --replicas=3
```

> ❗ Напрямую ReplicaSet создать нельзя. `kubectl run` создаёт Pod или Deployment


### Создание через yaml

```bash
nano rs.yaml
```

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: web-rs
  namespace: app
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx:1.27
        ports:
        - containerPort: 80
```

```bash
kubectl apply -f rs.yaml
```

### Удалить ReplicaSet
```bash
kubectl delete rs web-rs
kubectl -n app delete rs web-rs

# Через конфигурацию
kubectl delete -f rs.yaml
```

> ❗ При удалении ReplicaSet удаляются и его поды. Но есть нюанс — `orphan pods`

```bash
# Каскадное удаление, поды останутся (снимут ownerReference)
kubectl delete rs web-rs --cascade=orphan
```

## 