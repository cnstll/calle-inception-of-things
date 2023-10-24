#!/bin/bash

# Define variables
VAGRANT_BOX="hashicorp/bionic64"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5pzrve7SK7H6qxb/Ya/feq9750aF7JK8sluUVacP1vCwTD8TFbTGF2J4CbC+GRH0kPA+TXdwkS/zreFDAbhsPdmq784qFMbCYqNG2MNpsPbUd7rXy6Bpoi6t/RPThIAgL4uEl3YYG8BCWEAXNA+6zi7a2CRpQiFV+Hv+Z3OoLR6z7LiaRu4s2CTNSwkue4T5bbNEPqVZmPPRUV/HEVNpaP3JdUmnRe4nrM43l66/zgemRztgevCfFmcFSViEanjB0B/ZktkhtfkDEAWXO0HwAO12b/jidkIMQJGZEb9ONQrJTs7nQ5m9tWYfVK/qlpfuR9yfq/aiYo1SKFi6pUk8D calle@calle-VirtualBox"

# Start the Vagrant environment and provision the virtual machines
echo "Booting VMs..."
vagrant up

echo "...Done !"
# SSH into the Server machine
vagrant ssh calleS

# SSH into the ServerWorker machine
vagrant ssh calleSW

