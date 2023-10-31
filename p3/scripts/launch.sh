#!/bin/bash
# sudo chown -R $USER $HOME/.kube

# Create and launch cluster with k3d
k3d cluster create cluster-iot 
echo "cluster launched ✔"
sleep 10

# Download and install argocd
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update confs/charts/argo-cd/
echo "Downloaded helm chart for argocd ✔"
helm install --create-namespace --namespace argocd argo-cd confs/charts/argo-cd/
echo "Installed helm chart for argocd ✔"

echo "Waiting for cluster to be ready..."
EXPECTED_NUM_OF_RUNNING_POD=7
CURRENT_PODS_RUNNING=$(kubectl get pods -n argocd | grep " Running " | wc -l > /dev/null 2>&1)
while [[ ${CURRENT_PODS_RUNNING} -ne ${EXPECTED_NUM_OF_RUNNING_POD} ]]; do
        sleep 5
        echo "Probing current state of cluster.."
        CURRENT_PODS_RUNNING=$(kubectl get pods -n argocd | grep " Running " | wc -l)
        echo "CLUSTER INFO: ${CURRENT_PODS_RUNNING} pods out of ${EXPECTED_NUM_OF_RUNNING_POD} are running..." 
done
echo "Apps are ready ✔"

# Deploying different manifest
kubectl create namespace dev
kubectl apply --namespace argocd -f confs/app-project.yaml
kubectl apply --namespace argocd -f confs/wils-application.yaml

# Changing admin password to "password"
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'


echo "Login to argo: admin"
echo "Password to argo: password"
echo "Enter the following commands into 2 distinct tty to access the different services:"
echo "kubectl port-forward --namespace argocd svc/argo-cd-argocd-server 8080:443"
echo "kubectl port-forward --namespace dev service/wil-playground 8888:8888"