SERVER_IP="192.168.56.110"
# Env variables that will be used for the installation of k3s
export INSTALL_K3S_EXEC="server --node-ip ${SERVER_IP} --flannel-iface eth1 --write-kubeconfig-mode 644"
# Downloading and installing k3s
curl -sfL https://get.k3s.io | sh -s -

# Waiting for control to be fully ready in order to collect its config and its token
mkdir -v .kube/
KUBE_CONFIG="/etc/rancher/k3s/k3s.yaml"
while [ ! -f ${KUBE_CONFIG} ]; do
    sleep 2
    echo "Waiting for kubeconfig creation..."
done
cp -v /etc/rancher/k3s/k3s.yaml .kube/

# Collecting controller node token that will be passed to the agent
NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
TOKEN=$(cat ${NODE_TOKEN})
cp ${NODE_TOKEN} /vagrant_shared/

echo "Server configuration done ✔"