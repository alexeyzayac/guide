# Работа с namespace через kubectl

> `Namespace` — логическое разделение кластера на изолированные группы.
* ❗ Для многих namespaced-ресурсов ощущается как «мини-кластер», но не является отдельным виртуальным кластером.

## Стандартные namespace

| Namespace         | Назначение                                    |
|-------------------|-----------------------------------------------|
| `default`         | Для ресурсов, если namespace не указан        |
| `kube-system`     | Компоненты control plane и системные add-on’ы |
| `kube-public`     | Публичные данные, часто для cluster-info      |
| `kube-node-lease` | Lease-объекты для heartbeat нод               |

### Выводвсех типов ресурсов (kind), которые знает API-сервер кластера.

```bash
# только namespaced-ресурсы (живут внутри namespace).
kubectl api-resources --namespaced=true

 #только cluster-scoped-ресурсы (существуют на уровне всего кластера).
kubectl api-resources --namespaced=false
```

## Базовые команды

```bash
# Посмотреть все namespace
kubectl get namespaces
kubectl get ns

# С метками
kubectl get ns --show-labels

# Описать namespace
kubectl describe ns kube-system
```

## Создать namespace

```bash
kubectl create namespace app
```
### Создание через yaml

```bash
# Открыть файл в редакторе
nano namespace-app.yaml
```

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: app
  labels: # метки
    team: backend
    env: prod
```

```bash
# Запустить конфигурацию
kubectl apply -f namespace-app.yaml
```

### Удалить namespace

> ❗ Удаление namespace каскадно удалит все namespaced-ресурсы внутри.

```bash
kubectl delete ns app 

# Удалить через конфигурацию    
kubectl delete -f namespace-app.yaml
```

## Выбор пространства имён

```bash
# Поды в текущем namespace (по умолчанию "default")
kubectl get pods

# Поды в namespace "app"
kubectl get pods -n app

# Поды во всех namespace
kubectl get pods -A
kubectl get pods --all-namespaces

# Описать pod в определённом namespace
kubectl -n <namespace> describe pod <pod> 

# Описать все поды во всех namespace (будет очень много текста)
kubectl describe pod --all-namespaces
```

## Текущий namespace в контексте

```bash
# Посмотреть текущий namespace
kubectl config view --minify --output 'jsonpath={..namespace}'

# Переключить текущий namespace
kubectl config set-context --current --namespace=app

# Вернуть namespace по умолчанию
kubectl config set-context --current --namespace=default
```

## Namespace в манифестах

### Pod:

```bash
# Если namespace не указан в манифесте, можно указать при apply
kubectl apply -n app -f pod.yaml
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
  namespace: app
spec:
  containers:
  - name: nginx
    image: nginx
```

### ResourceQuota:

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: app-quota
  namespace: app
spec:
  hard:
    requests.cpu: "10"
    requests.memory: 20Gi
    limits.cpu: "20"
    limits.memory: 40Gi
    pods: "50"
```

### LimitRange:

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: app-limits
  namespace: app
spec:
  limits:
  - default:
      cpu: 500m
      memory: 512Mi
    defaultRequest:
      cpu: 100m
      memory: 128Mi
    type: Container
```

### NetworkPolicy:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-prod
  namespace: app
spec:
  podSelector: {}
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          env: prod
```