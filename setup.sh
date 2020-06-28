red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
# rm -rf ~/.minikube
# mkdir -p ~/goinfre/minikube
# ln -s ~/goinfre/minikube ~/.minikube

minikube delete

minikube start --vm-driver=virtualbox \
--cpus=2 --memory 3000
# --bootstrapper=kubeadm \
# --extra-config=kubelet.authentication-token-webhook=true

# make sure to not to do "minikube addons enable ingress" if you are working with MetalLB
minikube addons enable dashboard
sleep 1
echo "Eval..."
eval $(minikube docker-env) # eval $(minikube -p minikube docker-env)
export MINIKUBE_IP=$(minikube ip)
printf "Minikube IP: ${MINIKUBE_IP}\n"

sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/nginx/homepage-pde-bakk/beforesed.html > srcs/nginx/homepage-pde-bakk/index.html

# Create temp files and use sed on my used files
# sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/mysql/wordpress.sql > srcs/mysql/wordpress-tmp.sql
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/wpsetup.sh > srcs/wordpress/tmp.sh


echo "Building images..."
printf "Building nginx image:\t\t"
docker build -t nginx_alpine ./srcs/nginx/ > .nginxbuild.txt 2>&1 && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"
printf "Building ftps image:\t\t"
docker build -t ftps_alpine ./srcs/ftps2 --build-arg IP=${IP} > .ftpsbuild.txt 2>&1 && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"
printf "Building mysql image:\t\t"
docker build -t mysql_alpine ./srcs/mysql > .mysqlbuild.txt 2>&1 && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"
printf "Building wordpress image:\t"
docker build -t wordpress_alpine ./srcs/wordpress > .wordpressbuild.txt 2>&1 && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"
printf "Building phpmyadmin image:\t"
docker build -t phpmyadmin_alpine ./srcs/phpmyadmin > .phpmyadminbuild.txt 2>&1 && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"
printf "Building influxdb image:\t"
docker build -t influxdb_alpine ./srcs/influxdb2 > .influxdbbuild.txt 2>&1 && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"
printf "Building grafana image:\t\t"
docker build -t grafana_alpine ./srcs/grafana2 > .grafanabuild.txt 2>&1 && printf "[${grn}OK${end}]\n" || printf "[${red}NO${end}]\n"

sleep 3
kubectl apply -k ./srcs/
sleep 1
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

printf "Opening http://$MINIKUBE_IP in your browser...\n"
open http://$MINIKUBE_IP

# To enter terminal:
# kubectl exec -it <podname> sh
