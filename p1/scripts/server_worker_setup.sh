CONTROL_NODE_TOKEN=$(cat /vagrant_shared/node-token)


SERVER_WORKER_IP="192.168.56.111"
# Env variables that will be used for the installation of k3s
export INSTALL_K3S_EXEC="agent --node-ip ${SERVER_WORKER_IP} --flannel-iface eth1"
export K3S_URL=https://192.168.56.110:6443
export K3S_TOKEN=${CONTROL_NODE_TOKEN}

# Downloading and installing k3s
curl -sfL https://get.k3s.io | sh -s -

echo "Server worker configuration done ✔"