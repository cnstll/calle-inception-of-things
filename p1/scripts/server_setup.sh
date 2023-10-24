curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --flannel-backend none" K3S_TOKEN=12345 K3S_KUBECONFIG_MODE="644" sh -s -
sleep 15
pwd
sudo mkdir -v ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube