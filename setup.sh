# rm -rf ~/.minikube
# mkdir -p ~/goinfre/minikube
# ln -s ~/goinfre/minikube ~/.minikube

minikube delete

minikube start --vm-driver=virtualbox \
--cpus=4 --memory 8192
# --bootstrapper=kubeadm \
# --extra-config=kubelet.authentication-token-webhook=true

# make sure to not enable the ingress addon if you are working with MetalLB
minikube addons enable dashboard

echo "Eval..."
eval $(minikube docker-env)
export MINIKUBE_IP=$(minikube ip)
printf "Minikube IP: ${MINIKUBE_IP}\n"

sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/nginx/homepage-pde-bakk/beforesed.html > srcs/nginx/homepage-pde-bakk/index.html
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" srcs/wordpress/tmpwpconfig.php > srcs/wordpress/wp-config.php
echo "Building images..."
docker build -t nginx_alpine ./srcs/nginx/
docker build -t influxdb_alpine ./srcs/influxdb
docker build -t ftps_alpine --build-arg IP=${IP} ./srcs/ftps/
docker build -t grafana_alpine ./srcs/grafana
docker build -t wordpress_alpine ./srcs/wordpress

sleep 5
kubectl apply -k ./srcs/
sleep 1
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
# sleep 1
# kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
# ./apply.sh

# echo "\n\nHier: http://$MINIKUBE_IP"
printf "Opening http://$MINIKUBE_IP in your browser...\n"
open http://$MINIKUBE_IP # this wont work, you need the correct port:
minikube service nginx --url
# minikube dashboard

# To enter terminal:
# kubectl run -i --tty busybox --image=busybox --restart=Never -- sh 