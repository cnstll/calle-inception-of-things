whoami
id
pwd
SERVER_IP="192.168.56.110"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-external-ip=${SERVER_IP} --bind-address=${SERVER_IP} --flannel-iface=eth1 --write-kubeconfig-mode=644" sh -s -
pwd
mkdir -v /home/vagrant/.kube/
KUBE_CONFIG="/etc/rancher/k3s/k3s.yaml"
while [ ! -f ${KUBE_CONFIG} ]; do
    sleep 2
    echo "Waiting for kubeconfig creation..."
done
cp -v /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/
echo "The k3s config has been created and copied."

NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
while [ ! -e ${NODE_TOKEN} ]; do
    sleep 2
    echo "Waiting for server connection token creation..."
done
TOKEN=$(cat ${NODE_TOKEN})
echo "Server Token : ${TOKEN}"
cp ${NODE_TOKEN} /home/vagrant/
echo "Server configuration done ✔"