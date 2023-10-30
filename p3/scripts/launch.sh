# Create and launch cluster with k3d
k3d cluster create IoT
kubectl create namespace dev
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update confs/charts/argo-cd/
# sudo helm install argo-cd confs/charts/argo-cd/
sudo helm install --create-namespace --namespace argocd argo-cd confs/charts/argo-cd/
sudo kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
sudo kubectl port-forward svc/argo-cd-argocd-server 8080:443

# Apply Manifests

# Create a github repository and add manifests for wils app
# Get wils app from dockerhub
