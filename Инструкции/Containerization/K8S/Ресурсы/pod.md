# Pod в Kubernetes

> `Pod` — минимальная вычислительная единица в Kubernetes.
- ❗ `Pod` не контейнер. Контейнеры внутри пода — это уже деталь реализации (обычно Docker/containerd).
- Важно: внутри пода нельзя двум контейнерам слушать один и тот же порт — у них общий network namespace.

## Базовые команды

```bash
# Посмотреть поды в текущем namespace
kubectl get pods

# В конкретном namespace
kubectl -n app get pods

# Во всех namespace
kubectl get pods -A
kubectl get pods --all-namespaces

# С метками и дополнительными полями
kubectl get pods --show-labels
kubectl get pods -o wide

# Описать pod (фазы, события, контейнеры, тома)
kubectl describe pod my-pod
kubectl -n app describe pod my-pod
```

## Создать Pod

```bash
# Простой Pod с nginx
kubectl run my-pod --image=nginx

# С портом и метками, контейнер создаётся с именем пода
kubectl run my-pod --image=nginx --port=80 --labels="app=web,env=prod" -n app

# Интерактивный Pod с shell (для отладки)
kubectl run debug --image=busybox -it --rm -- sh
```

### Создание через yaml

```bash
nano pod-nginx.yaml
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
  namespace: app
  labels:
    app: web
    env: prod
spec:
  containers:
  - name: nginx
    image: nginx:1.27
    ports:
    - containerPort: 80
```

```bash
kubectl apply -f pod-nginx.yaml
```

### Удалить Pod
```bash
kubectl delete pod my-pod
kubectl -n app delete pod my-pod

# Удалить через конфигурацию
kubectl delete -f pod-nginx.yaml

# Удалить все поды в namespace
kubectl -n app delete pods --all
```
> ❗ Если Pod управляется Deployment/StatefulSet — он пересоздастся. Удалять надо сам контроллер, а не под.

## Просмотр логов и exec

```bash
# Логи пода (если один контейнер)
kubectl -n app logs web 

# Логи конкретного контейнера
kubectl -n app logs web -c nginx

# Следить за логами
kubectl -n app logs -f web

# Логи предыдущего запущенного контейнера (после рестарта)
kubectl -n app logs web --previous

# Зайти внутрь пода
kubectl -n app exec -it web -- /bin/bash
kubectl -n app exec -it web -c my-pod -- sh

# Зайти в разные контейнеры внутри одного пода
kubectl -n app exec -it web -c nginx   -- sh
kubectl -n app exec -it web -c sidecar -- sh

# Выполнить одну команду
kubectl -n app exec web -- ls /etc
```

## Мультиконтейнерные поды с Volumes

> В одном поде может быть несколько контейнеров. Паттерны:

* **Sidecar** - Вспомогательный контейнер рядом с основным. (Пример: log-shipper, envoy-proxy, filebeat.)
* **Init-контейнер** - Запускается до основных контейнеров, должен успешно завершиться. (Пример: подождать БД, склонировать репозиторий, выставить права.)

> Все контейнеры пода:
* делят один IP,
* общаются через `localhost`,
* могут делить volume,
* пишут логи в один поток (`kubectl logs` показывает по контейнерам отдельно).

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
  namespace: app
  labels:
    app: web
    env: prod
spec:


  initContainers:
  - name: init-content
    image: busybox:1.36
    command: ["sh", "-c", "echo '<h1>Hello from init</h1>' > /work/index.html"]
    volumeMounts:
    - name: content
      mountPath: /work

  containers:
  - name: nginx
    image: nginx:1.27
    ports:
    - containerPort: 80
    volumeMounts:
    - name: content
      mountPath: /usr/share/nginx/html
```

> Основные типы volumes:

| Тип                   | Что делает                            |
|-----------------------|---------------------------------------|
| emptyDir              | Временный каталог, живёт пока жив под |
| hostPath              | Каталог с ноды (опасно в проде)       |
| configMap             | Монтирует ConfigMap как файлы         |
| secret                | Монтирует Secret как файлы            |
| persistentVolumeClaim | PVC — постоянное хранилище            |
| nfs, csi              | Внешние хранилища                     |

## Переменные окружения

```yaml
spec:
  containers:
  - name: app
    image: myapp
    env:
    - name: APP_ENV
      value: prod
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: password
    envFrom:
    - configMapRef:
        name: app-config
```
> ❗ Порядок приоритетов (грубо): env > envFrom, а встроенные переменные (HOSTNAME, POD_NAME через downward API) — отдельно.

## Probes (проверки здоровья)

| Probe	         | Что проверяет | Что делает при провале                                        |
|----------------|---------------------------| --------------------------------------------------|
| livenessProbe  | Живой ли контейнер        | Перезапускает контейнер                           |
| readinessProbe | Готов ли принимать трафик | Убирает из Service endpoints                      |
| startupProbe   | Запустился ли             | Пока не пройдёт — не запускает liveness/readiness |

```yaml
spec:
  containers:
  - name: app
    image: myapp
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 5
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 3
      periodSeconds: 3
```

## Requests (сколько гарантированно) и Limits (максимум, при превышении)

```yaml
spec:
  containers:
  - name: app
    image: myapp
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 500m
        memory: 512Mi
```

> Соотношение CPU/memory в requests и limits влияет на QoS-класс пода:

| QoS        | Когда                                |
|------------|--------------------------------------|
| Guaranteed | requests = limits у всех контейнеров |
| Burstable	 | requests < limits хотя бы у одного   |
| BestEffort | ни requests, ни limits не заданы     |

# Метки и селекторы

```yaml
metadata:
  labels:
    app: web
    env: prod
    tier: frontend
```