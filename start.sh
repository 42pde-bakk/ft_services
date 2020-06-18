# rm -rf ~/.minikube
# mkdir -p ~/goinfre/minikube
# ln -s ~/goinfre/minikube ~/.minikube

minikube delete

minikube start --vm-driver=virtualbox
minikube addons enable ingress
minikube addons enable dashboard

cd srcs

minikube dashboard &

eval $(minikube docker-env)

export MINIKUBE_IP=$(minikube ip)

sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" nginx/tmp.html > nginx/index.html

docker build -t nginx_alpine nginx/

kubectl apply -k ./

echo "\n\n\nLink to the site: http://$MINIKUBE_IP"
