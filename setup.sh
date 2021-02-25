#! /bin/sh


minikube delete --all
# Create the Namespace (VM) that wrap everything => Minikube for creating it localy
minikube start --vm-driver=virtualbox
minikube status

minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb
#minikube addons enable logviewer


# Start the docker environment on the Minikube VM
eval $(minikube docker-env)

# Installing Mettalib
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
if [ "$(kubectl get secrets --namespace metallb-system | grep memberlist)" = "" ]
then
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
fi
kubectl apply -f srcs/Mettalib/config.yaml > /dev/null

# set docker images
eval $(minikube docker-env)
docker build srcs/nginx -t img-nginx
kubectl apply -f srcs/nginx/deployment.yaml

minikube dashboard

