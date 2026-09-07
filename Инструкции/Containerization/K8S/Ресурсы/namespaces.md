



## Выбор пространства имён

```bash
#Поды в текущем namespace (по умолчанию "default")
kubectl get pods

#Поды в namespace "app"
kubectl -n app get pods

#Поды во всех namespace
kubectl get pods -A
```


Выбор пространства имён (namespace)
Текущий (по умолчанию default):
kubectl describe pod my-pod

Конкретный:
kubectl -n app describe pod my-pod

Все неймспейсы (для кластерных ресурсов типа node это игнорируется):
kubectl describe pod --all-namespaces — опишет все поды во всех NS (будет очень много текста)