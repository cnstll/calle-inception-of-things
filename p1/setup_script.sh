#!/bin/bash

# Define variables
VAGRANT_BOX="generic/alpine38"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7pT5mgfXYUMlQf3hFjWCiVnE42HhXfZia8z+Nrsomw5sBXh1OCs+UVi3NiBPg2g/ipDdRj0pRTH/S+M6iPEi3wTEfoLAB+FFXB2cfOIph7PWwwgLflQVP1STMTDT0Wvm/uxlm5hSfqz7bPB9OarGznfKMjbRT531u4Xu+v9zu5NKc42wO6w9TUfkDaA8ZmimpIpwu5bvIugynpKkwTAQ007LZw+OSb/di7P5Fk0+G6soYlxzfu1ixSoUJU9ZHv9XypDBcbmXsET2Ce3zym11yRCpDRvTAmHlBmSWlPAgYkW3PfHxB1gH6YIRfieGZH79kwILSPwepEWN2+MolFopNwti8wuK8peLxxPfP27iJ8sZV4C8VrSMWcEMQ124ym/jZeHnFcpvwxMQfx0R3Kzv4Dko9mZc3hJF272zdPvZb4ZRjX9ZEiYwQoOkStchZfldOebSwcoWlmZRaLlEH2IqG4sONZiGRFMf2zMQotMUp1gi1ipptFcwaed6YPGa+6Gc= constantalle@MacBook-Pro-de-Constant.local"

cat <<EOL > Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.define "calleS" do |server|
    server.vm.box = "$VAGRANT_BOX"
    server.vm.network "private_network", type: "dhcp"
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
    server_worker.vm.box = "$VAGRANT_BOX"
    server_worker.vm.network "private_network", type: "dhcp"
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

