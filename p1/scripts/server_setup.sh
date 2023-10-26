whoami
id
pwd
ls -a
#rc-update add cgroups default
SERVER_IP="192.168.56.110"
export INSTALL_K3S_EXEC="server --node-ip ${SERVER_IP} --flannel-iface eth1 --write-kubeconfig-mode 644"
curl -sfL https://get.k3s.io | sh -s -

mkdir -v .kube/
KUBE_CONFIG="/etc/rancher/k3s/k3s.yaml"
while [ ! -f ${KUBE_CONFIG} ]; do
    sleep 2
    echo "Waiting for kubeconfig creation..."
done
cp -v /etc/rancher/k3s/k3s.yaml .kube/
echo "The k3s config has been created and copied."

NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
TOKEN=$(cat ${NODE_TOKEN})
echo "Server Token : ${TOKEN}"
cp ${NODE_TOKEN} /vagrant_shared/
echo "Server configuration done ✔"