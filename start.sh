# rm -rf ~/.minikube
# mkdir -p ~/goinfre/minikube
# ln -s ~/goinfre/minikube ~/.minikube

# open --background -a Docker

minikube delete

minikube start --vm-driver=virtualbox \
--bootstrapper=kubeadm \
--extra-config=apiserver.service-node-port-range=1-30000 \
--extra-config=kubelet.authentication-token-webhook=true

minikube addons enable ingress
# minikube addons enable dashboard

eval $(minikube docker-env)
export MINIKUBE_IP=$(minikube ip)

docker build -t nginx_alpine ./srcs/nginx/

./apply.sh

echo "\n\nHier: http://$MINIKUBE_IP"
# minikube dashboard