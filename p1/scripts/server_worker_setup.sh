whoami
id
pwd
CONTROL_NODE_TOKEN=$(cat /home/vagrant/node-token)
echo "control node token from server_worker : ${CONTROL_NODE_TOKEN}"
SERVER_WORKER_IP="192.168.56.111"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --node-external-ip=${SERVER_WORKER_IP} --flannel-iface=eth1" K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=${CONTROL_NODE_TOKEN} sh -s
echo "Server worker configuration done ✔"