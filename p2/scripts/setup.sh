SERVER_IP="192.168.56.110"
# Env variables that will be used for the installation of k3s
export INSTALL_K3S_EXEC="server --node-ip ${SERVER_IP} --flannel-iface eth1 --write-kubeconfig-mode 644"
# Downloading and installing k3s
curl -sfL https://get.k3s.io | sh -s -

# Waiting for control to be fully ready in order to collect its config and its token
# mkdir -v .kube/
KUBE_CONFIG="/etc/rancher/k3s/k3s.yaml"
while [ ! -f ${KUBE_CONFIG} ]; do
    sleep 2
    echo "Waiting for kubeconfig creation..."
done

# Cluster access
su - vagrant -c "export KUBECONFIG=${KUBE_CONFIG}"

# Add the alias for the vagrant user
echo 'alias k="kubectl"' >> /home/vagrant/.profile

# Source the .profile for the vagrant user
su - vagrant -c "source /home/vagrant/.profile"

echo "Server configuration done ✔"

echo "Probing current state of k3s controller.."
while [[ $(kubectl get nodes | grep " Ready " | wc -l) -ne 1 ]]; do
        sleep 5
        echo "Waiting for k3s controller to be ready..."
        echo "Probing current state of k3s controller.."
        kubectl get nodes
done
echo "Controller is ready ✔"

# Launch and config the cluster's apps
kubectl apply -f confs/kube/ingress/
kubectl apply -f confs/kube/apps/
echo "Apps deployed ✔"

# Waiting for the cluster to be ready
EXPECTED_NUM_OF_RUNNING_POD=10
echo "Waiting for cluster to be ready..."
CURRENT_PODS_RUNNING=$(kubectl get all -A | grep "pod/" | grep " Running " | wc -l)
while [[ ${CURRENT_PODS_RUNNING} -ne ${EXPECTED_NUM_OF_RUNNING_POD} ]]; do
        sleep 10
        echo "Probing current state of cluster.."
        CURRENT_PODS_RUNNING=$(kubectl get all -A | grep "pod/" | grep " Running " | wc -l)
        echo "CLUSTER INFO: ${CURRENT_PODS_RUNNING} pods out of ${EXPECTED_NUM_OF_RUNNING_POD} are running..." 
done
echo "Apps are ready ✔"