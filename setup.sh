#!/bin/bash
# function logs() {
# 	kubectl logs $(kubectl get pods | grep "$1" | awk '{print $1}')
# }
# function attach() {
# 	kubectl exec -it $(kubectl get pods | grep "$1" | awk '{print $1}') sh
# }
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
rm -rf ~/.minikube
mkdir -p ~/goinfre/minikube
ln -s ~/goinfre/minikube ~/.minikube

:> errlog.txt
:> log.log
minikube delete
# sh cleanup.sh >> log.log 2>> /dev/null

minikube start	--vm-driver=virtualbox \
				--cpus=2 --memory 3000 \
				>> log.log 2>> errlog.txt

				# --bootstrapper=kubeadm	\
				# --extra-config=kubelet.authentication-token-webhook=true \
# minikube addons enable metallb >> log.log 2>>errlog.txt && sleep 2 && kubectl apply -f ./srcs/metallb.yaml >> log.log 2>>errlog.txt
kubectl apply -f ./srcs/megametallb.yaml >> log.log 2>>errlog.txt
minikube addons enable default-storageclass >> log.log 2>> errlog.txt
minikube addons enable storage-provisioner >> log.log 2>> errlog.txt
minikube addons enable dashboard >> log.log 2>> errlog.txt
echo "Done starting fam"
eval $(minikube docker-env) # eval $(minikube -p minikube docker-env)
# docker system prune -f > /dev/null
export MINIKUBE_IP=$(minikube ip)
printf "Minikube IP: ${MINIKUBE_IP}\n"

# sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/tmp.sh > srcs/wordpress/setup.sh
# kubectl apply -f ./srcs/metallb.yaml >> log.log

printf "Building and deploying ftps:\t\t"
docker build -t ftps_alpine ./srcs/ftps2 --build-arg IP=${IP} > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"; kubectl apply -f ./srcs/ftps.yaml >> log.log 2>> errlog.txt

printf "Building and deploying mysql:\t\t"
docker build -t mysql_alpine ./srcs/mysql > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"; kubectl apply -f ./srcs/mysql.yaml >> log.log 2>> errlog.txt

printf "Building and deploying wordpress:\t"
docker build -t wordpress_alpine ./srcs/wordpress > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"; kubectl apply -f ./srcs/wordpress.yaml >> log.log 2>> errlog.txt

printf "Building and deploying phpmyadmin:\t"
docker build -t phpmyadmin_alpine ./srcs/phpmyadmin > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"; kubectl apply -f ./srcs/phpmyadmin.yaml >> log.log 2>> errlog.txt 

printf "Building and deploying influxdb:\t"
docker build -t influxdb_alpine ./srcs/influxdb2 >> /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"; kubectl apply -f ./srcs/influxdb.yaml >> log.log 2>> errlog.txt

printf "Building and deploying grafana:\t\t"
docker build -t grafana_alpine ./srcs/grafana2 > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"; kubectl apply -f ./srcs/grafana.yaml >> log.log 2>> errlog.txt

sleep 5;
WORDPRESS_IP=`kubectl get services | awk '/wordpress-svc/ {print $4}'`
PHPMYADMIN_IP=`kubectl get services | awk '/phpmyadmin-svc/ {print $4}'`
GRAFANA_IP=`kubectl get services | awk '/grafana-svc/ {print $4}'`
printf "WP_IP=$WORDPRESS_IP, PMA=$PHPMYADMIN_IP, GRAF=$GRAFANA_IP\n"
printf "Building and deploying nginx:\t\t"
sed -e "s/PHPMYADMIN_IP/$PHPMYADMIN_IP/g" -e "s/WORDPRESS_IP/$WORDPRESS_IP/g" -e "s/GRAFANA_IP/$GRAFANA_IP/g" srcs/nginx/homepage-pde-bakk/beforesed.html > srcs/nginx/homepage-pde-bakk/index.html
docker build -t nginx_alpine ./srcs/nginx > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"; kubectl apply -f ./srcs/nginx.yaml >> log.log 2>> errlog.txt

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> log.log 2>> errlog.txt
# open http://$MINIKUBE_IP
# To enter terminal:
# kubectl exec -it <podname> sh
