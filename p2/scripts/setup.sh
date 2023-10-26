# Install K3s
  echo '###Installing K3S..'
  SERVER_IP="192.168.56.110"
  export INSTALL_K3S_EXEC="server --node-ip ${SERVER_IP} --write-kubeconfig-mode 644"
  curl -sfL https://get.k3s.io | sh -s -

   # Wait for K3s to start and create k3s.yaml
   # Set the KUBECONFIG environment variable
  export KUBECONFIG="/etc/rancher/k3s/k3s.yaml"

   while [ ! -f ${KUBECONFIG} ]; do
    sleep 2
    echo "Waiting for kubeconfig creation..."
  done
  echo "K3s installation and configuration completed."