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
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/wp-config.php > srcs/wordpress/wp-config-tmp.php


echo "Building images..."
docker build -t nginx_alpine ./srcs/nginx/ > .nginxbuild.txt 2>&1
docker build -t ftps_alpine ./srcs/ftps/ --build-arg IP=${IP} > .ftpsbuild.txt 2>&1
docker build -t mysql_alpine ./srcs/mysql > .mysqlbuild.txt 2>&1
docker build -t wordpress_alpine ./srcs/wordpress> .wordpressbuild.txt 2>&1
docker build -t phpmyadmin_alpine ./srcs/phpmyadmin > .phpmyadminbuild.txt 2>&1
docker build -t influxdb_alpine ./srcs/influxdb > .influxdbbuild.txt 2>&1
docker build -t grafana_alpine ./srcs/grafana > .grafanabuild.txt 2>&1

sleep 5
kubectl apply -k ./srcs/
sleep 1
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

printf "Opening http://$MINIKUBE_IP in your browser...\n"
open http://$MINIKUBE_IP

# To enter terminal:
# kubectl run -i --tty busybox --image=busybox --restart=Never -- sh
