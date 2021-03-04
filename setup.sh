#! /bin/sh

function start_minikube() {
    #minikube stop
    #minikube delete --all

    # Create the Namespace (VM) that wrap everything 
    minikube start --vm-driver=virtualbox
    minikube status

    minikube addons enable metrics-server
    minikube addons enable dashboard
    minikube addons enable metallb

    #minikube kubectl -- get po -A
    # create the cluster

    # Start the docker environment on the Minikube VM
    # Minikube creates a specific VM in VirtualBox that will run your Docker images. 
    # You need to link your shell with the Minikube context
    #eval $(minikube docker-env)
}

# function metalib_config() {
#     kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
#     kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
#     kubectl apply -f srcs/metalib/config.yaml
# }

function main() {
    #start_minikube
    kubectl apply -f srcs/metalib/config.yaml
    minikube start --vm-driver=virtualbox
    minikube status

    minikube addons enable metrics-server
    minikube addons enable dashboard
    minikube addons enable metallb

    #docker-machine rm default
    #docker-machine create --driver virtualbox default
    #eval $(docker-machine env default)
    eval $(minikube docker-env)

    docker build srcs/nginx -t nginx
    kubectl apply -f srcs/nginx/deployment.yaml

    docker build srcs/mysql -t mysql
    kubectl apply -f srcs/mysql/deployment.yaml
    kubectl apply -f srcs/mysql/pvc.yaml
    kubectl apply -f srcs/mysql/secret.yaml
    kubectl apply -f srcs/mysql/service.yaml

    kubectl apply -f srcs/wordpress/pvc.yaml
    kubectl apply -f srcs/wordpress/deployment.yaml
    kubectl apply -f srcs/wordpress/service.yaml

    # https://medium.com/@taweesoft/chapter-1-how-to-easily-deploy-your-web-on-kubernetes-83209a8618be
    # https://blog.gojekengineering.com/diy-set-up-telegraf-influxdb-grafana-on-kubernetes-d55e32f8ce48
    
    minikube dashboard
}

main

### INFOS

# Debug Docker
# docker-machine rm default
# docker-machine create --driver virtualbox default
# # Used for first run
# eval $(docker-machine env default)
# # For testing purpose
# docker run hello-world

# NGINX 
# Nginx is a web server that can provide web pages and execute PHP.
# You need to create a simple Nginx server, it has to be fetchable through Ingres, 
# which is a more advanced version of service. 
# Port 443 is for SSL connection (https). 
# You can create a SSL certificate with Openssl. 
# This container needs to provide a SSH connection. 
# SSH is used to access a computer remotly through a shell. 
# A really simple way to create a SSH server is through the openssh package and then run the sshd daemon.

# METALLB
# Metallb est un load balancer qui permet aux autres services de type loadbalancer 
# d'être accessibles depuis l'extérieur du cluster. C'est une 'magouille' qu'on doit 
# faire pour pouvoir faire tourner le cluster sur une vm et pas dans un cloud avec un 
# environnement dédié et adapté. 
# Si tu enlève metallb tu verras que toutes tes external ip resteront en pending

# minikube kubectl -- get po -A

# INFLUXDB
# InfluxDB is an open-source time series database. Being a time series database, 
# it suits the intensive workloads of storing and retrieving time-based data 
# like application metrics, system health metrics (CPU, Memory, Network, Disk) usage etc.

# TELEGRAF
# Telegraf is an agent for collecting, processing, aggregating, and writing metrics. 
# It supports multiple outputs, InfluxDB being one of them.

# Grafana
# Grafana is an open source visualization tool. It is used to create dashboards, 
# and offers features and plugins to make them dynamic.

# ON VM(linux)
# https://www.notion.so/Ft_services-VM-852d4f9b0d9a42c1a2de921e4a2ac417