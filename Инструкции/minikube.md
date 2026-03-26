minikube start --driver=virtualbox --cpus=4 --memory=8gb --disk-size=5gb -p MYMINIKUBE

minikube profile list

minikube status -p MYMINIKUBE

minikube profile MYMINIKUBE - профииль по умолчанию для minikube

minikube status

minikube ip

minikube ssh

minikube logs

minikube dashboard

minikube addons list

minikube image ls

minikube image load nginx:latest











kubectl get nodes

kubectl describe nodes

kubectl get pods -A - Посмотреть все поды во всех namespace

kubectl get pods -o wide

kubectl logs <pod-name>

kubectl exec -it <pod-name> -- /bin/bash

kubectl get svc

kubectl get deploy



Посмотреть, какие ресурсы используют больше всего CPU/памяти (если включен metrics-server):

kubectl top nodes
kubectl top pods