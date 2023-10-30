# Create and launch cluster with k3d
whoami
sudo chown -R $USER $HOME/.kube
k3d cluster create cluster-iot
echo "cluster launched ✔"
kubectl create namespace dev
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update confs/charts/argo-cd/
echo "Downloaded helm chart for argocd ✔"
# sudo helm install argo-cd confs/charts/argo-cd/
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
kubectl apply --namespace argocd -f confs/wils-application.yaml

echo "Password: $(kubectl get secret --namespace argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
kubectl port-forward --namespace argocd svc/argo-cd-argocd-server 8080:443
# Apply Manifests
# Create a github repository and add manifests for wils app
# Get wils app from dockerhub
