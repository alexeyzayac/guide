https://yandex.cloud/ru/docs/cli/quickstart?&utm_referrer=https%3A//github.com/alexeyzayac/devops-netology/tree/15.02_iaac_in_vm

yc init


yc vpc network create \
  --name net \
  --labels my-label=netology \
  --description "My network"

yc vpc subnet create \
  --name my-subnet-a \
  --zone ru-central1-a \
  --range 10.1.2.0/24 \
  --network-name net \
  --description "My subnet"

yc compute image list

yc compute instance create \
  --name my-debian-from-packer \
  --zone ru-central1-a \
  --create-boot-disk image-name=debian-11-docker \
  --network-interface subnet-id=e9b8bj5p4odf1ffjn7gi,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/yandex.cloud/cloud-alexeyzayac.pub


yc compute instance list


yc compute instance delete --name my-debian-from-packer