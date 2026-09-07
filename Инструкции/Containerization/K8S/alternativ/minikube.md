```bash
#Узнать версию
minikube version

minikube status


```







```bash
#Поднимает с установленным плагином Calico
minikube start --driver=virtualbox --cpus=4 --memory=4gb --disk-size=20gb -p zayac
minikube start --driver=virtualbox --cpus=4 --memory=4gb --disk-size=20gb -p zayac --cni=calico
```


minikube start --driver=virtualbox --cpus=4 --memory=8gb --disk-size=20gb -p <имя>

minikube profile list

minikube status -p MYMINIKUBE

minikube profile MYMINIKUBE - профииль по умолчанию для minikube

minikube ip

minikube ssh

minikube logs

minikube dashboard

minikube addons list

minikube image ls

minikube image load nginx:latest
