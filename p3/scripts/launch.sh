#!/bin/bash
# If any issue with kubectl arise you may want to modify access rights
# sudo chown -R $USER $HOME/.kube

# Create and launch cluster with k3d
k3d cluster create cluster-iot -p 8080:80@loadbalancer --agents 2
echo "cluster launched ✔"
sleep 5

# Creating namespaces
kubectl create namespace dev
kubectl create namespace argocd
echo "dev and argocd namespaces created ✔"


# Download and install argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > /dev/null 2>&1
echo "Argo CD installed ✔"

echo "Waiting for Argo CD to be ready..."
EXPECTED_NUM_OF_RUNNING_POD=7
CURRENT_PODS_RUNNING=$(kubectl get pods -n argocd | grep " Running " | wc -l > /dev/null 2>&1)
while [[ ${CURRENT_PODS_RUNNING} -ne ${EXPECTED_NUM_OF_RUNNING_POD} ]]; do
        sleep 5
        echo "Probing current state of cluster.."
        CURRENT_PODS_RUNNING=$(kubectl get pods -n argocd | grep " Running " | wc -l)
        echo "CLUSTER INFO: ${CURRENT_PODS_RUNNING} pods out of ${EXPECTED_NUM_OF_RUNNING_POD} are running..." 
done
echo "Argo CD is fully running ✔"

# Applying Project and Application for Argo 
kubectl apply --namespace argocd -f confs/app-project.yaml
kubectl apply --namespace argocd -f confs/wils-application.yaml

# Changing admin password to "password"
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

# Connection informations
echo "Login to argo: admin"
echo "Password to argo: password"
echo "Enter the following commands into 2 distinct tty to access the different services:"
echo "kubectl port-forward --namespace argocd svc/argocd-server 8080:443"
echo "kubectl port-forward --namespace dev service/wil-playground 8888:8888"