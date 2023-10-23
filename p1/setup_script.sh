#!/bin/bash

# Define variables
VAGRANT_BOX="hashicorp/bionic64"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5pzrve7SK7H6qxb/Ya/feq9750aF7JK8sluUVacP1vCwTD8TFbTGF2J4CbC+GRH0kPA+TXdwkS/zreFDAbhsPdmq784qFMbCYqNG2MNpsPbUd7rXy6Bpoi6t/RPThIAgL4uEl3YYG8BCWEAXNA+6zi7a2CRpQiFV+Hv+Z3OoLR6z7LiaRu4s2CTNSwkue4T5bbNEPqVZmPPRUV/HEVNpaP3JdUmnRe4nrM43l66/zgemRztgevCfFmcFSViEanjB0B/ZktkhtfkDEAWXO0HwAO12b/jidkIMQJGZEb9ONQrJTs7nQ5m9tWYfVK/qlpfuR9yfq/aiYo1SKFi6pUk8D calle@calle-VirtualBox"

cat <<EOL > Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.define "calleS" do |server|
    server.vm.box = "$VAGRANT_BOX"
    server.vm.hostname = "calleS"
    server.vm.network "private_network", type: "static", ip: "192.168.56.110"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
    server.vm.provision "shell", inline: <<-SHELL
      # Install K3s in controller mode
      curl -sfL https://get.k3s.io | sh -
      # Copy Kubeconfig to the local machine
      cp /etc/rancher/k3s/k3s.yaml /vagrant/k3s-controller.yaml
    SHELL
  end

  config.vm.define "calleSW" do |server_worker|
    server_worker.vm.hostname = "calleSW"
    server_worker.vm.box = "$VAGRANT_BOX"
    server_worker.vm.network "private_network", type: "static", ip: "192.168.56.111"
    server_worker.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
    server_worker.vm.provision "shell", inline: <<-SHELL
      # Install K3s in agent mode
      curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 sh -
    SHELL
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo '$SSH_PUBLIC_KEY' >> /home/vagrant/.ssh/authorized_keys
  SHELL
end
EOL

# Start the Vagrant environment and provision the virtual machines
echo "Booting VMs..."
vagrant up

echo "...Done !"
# SSH into the Server machine
vagrant ssh calleS

# SSH into the ServerWorker machine
vagrant ssh calleSW

