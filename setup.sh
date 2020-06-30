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

# minikube delete
sh cleanup.sh

minikube start	--vm-driver=virtualbox \
				--cpus=2 --memory 3000 \
				--bootstrapper=kubeadm	\
				--extra-config=kubelet.authentication-token-webhook=true \
				--extra-config=apiserver.service-node-port-range=3000-35000

minikube addons enable metallb
echo "Eval..."
eval $(minikube docker-env) # eval $(minikube -p minikube docker-env)
export MINIKUBE_IP=$(minikube ip)
printf "Minikube IP: ${MINIKUBE_IP}\n"

# sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/nginx/homepage-pde-bakk/beforesed.html > srcs/nginx/homepage-pde-bakk/index.html
# sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/tmp.sh > srcs/wordpress/setup.sh

kubectl apply -f ./srcs/metallb.yaml > configlog.txt
echo "Building images..."
echo "images errlog" > errlog.txt
printf "Building ftps image:\t\t"
docker build -t ftps_alpine ./srcs/ftps2 --build-arg IP=${IP} > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" && kubectl apply -f ./srcs/ftps.yaml >> configlog.txt || printf "[${red}NO${end}]\n"
printf "Building mysql image:\t\t"
docker build -t mysql_alpine ./srcs/mysql > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" && kubectl apply -f ./srcs/mysql.yaml >> configlog.txt || printf "[${red}NO${end}]\n"
printf "Building wordpress image:\t"
docker build -t wordpress_alpine ./srcs/wordpress > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" && kubectl apply -f ./srcs/wordpress.yaml >> configlog.txt || printf "[${red}NO${end}]\n"
printf "Building phpmyadmin image:\t"
docker build -t phpmyadmin_alpine ./srcs/phpmyadmin > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" && kubectl apply -f ./srcs/phpmyadmin.yaml >> configlog.txt || printf "[${red}NO${end}]\n"
printf "Building influxdb image:\t"
docker build -t influxdb_alpine ./srcs/influxdb2 >> /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" && kubectl apply -f ./srcs/influxdb.yaml >> configlog.txt || printf "[${red}NO${end}]\n"
printf "Building grafana image:\t\t"
docker build -t grafana_alpine ./srcs/grafana2 > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" && kubectl apply -f ./srcs/grafana.yaml >> configlog.txt || printf "[${red}NO${end}]\n"
printf "Building nginx image:\t\t"
docker build -t nginx_alpine ./srcs/nginx > /dev/null 2>>errlog.txt && printf "[${grn}OK${end}]\n" && kubectl apply -f ./srcs/nginx.yaml >> configlog.txt || printf "[${red}NO${end}]\n"

# kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# To enter terminal:
# kubectl exec -it <podname> sh
