# rm -rf ~/.minikube
# mkdir -p ~/goinfre/minikube
# ln -s ~/goinfre/minikube ~/.minikube

minikube delete

minikube start --driver=virtualbox \
--addons dashboard \
--addons ingress

minikube dashboard

cd srcs

docker build -t nginx nginx/

# -k applies a whole folder full of JSON/YAML files
# -f does a single one
kubectl apply -k .
#Apply a configuration to a resource by filename or stdin. The resource name must be specified.
