# rm -rf ~/.minikube
# mkdir -p ~/goinfre/minikube
# ln -s ~/goinfre/minikube ~/.minikube

minikube delete

minikube start --driver=virtualbox
