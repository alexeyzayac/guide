```bash
#поменять контекст имён
kubectl config set-context --current --namespace=app
```

```bash
#Применить манифест
kubectl apply -f pod.yaml
```

```bash
#Выполнить команду внутри контейнера (первого)
kubectl exec hello-world -- ps aux

#Зайти под bash внутрь контейнера (первого)
kubectl exec -it hello-world -- bash

#Зайти в контейнер с именеи echoserver
kubectl exec -it hello-world -c echoserver -- bash
```

```bash
#Удалить pod
kubectl delete pod hello-world
```

```bash
#Пробросьте локальный порт (например, `8080`) на порт пода `8080`:
kubectl port-forward pod/hello-world 8080:8080

#Пробросьте локальный порт (например, `9999`) на порт сервиса `8088`:
kubectl port-forward service/hello-world-svc 9999:8088
```