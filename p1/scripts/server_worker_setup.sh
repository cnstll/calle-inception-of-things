whoami
id
pwd
# sudo -i
# rc-update add cgroups default
CONTROL_NODE_TOKEN=$(cat /vagrant_shared/node-token)
echo "control node token from server_worker : ${CONTROL_NODE_TOKEN}"

SERVER_WORKER_IP="192.168.56.111"
export INSTALL_K3S_EXEC="agent --node-ip ${SERVER_WORKER_IP} --flannel-iface eth1"
export K3S_URL=https://192.168.56.110:6443
export K3S_TOKEN=${CONTROL_NODE_TOKEN}
curl -sfL https://get.k3s.io | sh -s -

echo "Server worker configuration done ✔"