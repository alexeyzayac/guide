microk8s status --wait-ready
microk8s command
microk8s kubectl get nodes
microk8s status
microk8s config

microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443
microk8s refresh-certs --cert front-proxy-client.crt