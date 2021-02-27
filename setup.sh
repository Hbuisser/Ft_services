#! /bin/sh

function start_minikube() {
    minikube delete --all
    # Create the Namespace (VM) that wrap everything 
    # => Minikube for creating it localy
    minikube start --vm-driver=virtualbox
    minikube status

    minikube addons enable metrics-server
    minikube addons enable dashboard
    minikube addons enable metallb
    #minikube addons enable logviewer

    # Start the docker environment on the Minikube VM
    # Minikube creates a specific VM in VirtualBox that will run your Docker images. 
    # You need to link your shell with the Minikube context
    eval $(minikube docker-env)
}

function check_docker() {
    docker -v
	if [ "$?" != 0 ]
	then
		printf "Docker isn't installed!\n"
		printf "You can download it here : https://www.thegeekdiary.com/how-to-install-docker-on-mac/ \n"
        exit 1
	else
		printf "Docker is installed ✅\n"
	fi
}

function metalib_config() {
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
    if [ "$(kubectl get secrets --namespace metallb-system | grep memberlist)" = "" ]
    then
        kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
    fi
    # https://metallb.universe.tf/configuration/
    kubectl apply -f srcs/metalib/config.yaml > /dev/null
}

function check_minikube() {
    # https://minikube.sigs.k8s.io/docs/start/
    minikube version
	if [ "$?" != 0 ]
	then
		printf "Minikube isn't installed!\n"
        brew install minikube
        sudo mv minikube /usr/local/bin
        printf "Minikube is installed ✅\n"
	else
		printf "Minikube is installed ✅\n"
	fi
}

function check_brew() {
	brew -v
	# $? is the exit status of the last executed command / true returns 0, false 1
	if [ "$?" != 0 ]
	then 
		printf "Brew isn't installed!\n"
		read -p "Do you want to install brew? (Y/N): " REP
		if [[ $REP = "Y" || $REP = "y" || $REP = "" ]]
		then
			printf "Installing brew...\n"
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		else
			printf "Brew is required for this program\n"
			# exit 1 means exiting with false at the end
			exit 1
		fi
	else
		printf "Brew is installed ✅\n"
	fi
}

function main() {
    #check_brew
    #check_minikube
    #metalib_config
    #check_docker
    #start_minikube

    docker build srcs/nginx -t img-nginx
    kubectl apply -f srcs/nginx/deployment.yaml

    # https://blog.gojekengineering.com/diy-set-up-telegraf-influxdb-grafana-on-kubernetes-d55e32f8ce48
    
    minikube dashboard
}

main

### INFOS

# NGINX 
# Nginx is a web server that can provide web pages and execute PHP.
# You need to create a simple Nginx server, it has to be fetchable through Ingres, 
# which is a more advanced version of service. 
# Port 443 is for SSL connection (https). 
# You can create a SSL certificate with Openssl. 
# This container needs to provide a SSH connection. 
# SSH is used to access a computer remotly through a shell. 
# A really simple way to create a SSH server is through the openssh package and then run the sshd daemon.