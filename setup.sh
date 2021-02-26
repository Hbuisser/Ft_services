#! /bin/sh

function start_minikube() {
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
}

function check_docker() {
    docker -v
	if [ "$?" != 0 ]
	then
		printf "Docker isn't installed!\n"
        sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate \
            docker-logrotate docker-engine
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo yum-config-manager --enable docker-ce-nightly
        sudo yum-config-manager --enable docker-ce-test
        sudo yum install docker-ce docker-ce-cli containerd.io
		printf "Docker is installed ✅\n"
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
    kubectl apply -f srcs/metalib/config.yaml > /dev/null
}

function check_minikube() {
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

function main() {
    check_minikube
    metalib_config
    check_docker
    start_minikube
    #docker build srcs/nginx -t img-nginx
    #kubectl apply -f srcs/nginx/deployment.yaml
    #minikube dashboard
}

main