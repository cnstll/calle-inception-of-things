# inception-of-things


## About Vagrant
**Vagrant** is an open-source tool for managing and provisioning virtual machines for development and testing purposes.  
It provides a convenient way to create, configure, and manage virtualized development environments, making it easier  
to work on projects that require specific dependencies, configurations, or multiple machines.  

A **Vagrantfile** is the configuration file used to define the virtual machine(s) you want to create and how they should be provisioned.  
It is typically written in Ruby and serves as a blueprint for Vagrant to follow when creating and managing the VMs.  
  
A **Vagrant box** is a pre-configured, reusable virtual machine image that serves as a base for creating and provisioning virtual machines using Vagrant. Boxes are designed to make it easy to distribute and share development environments, ensuring that developers work on the same foundation with a consistent setup. 

## Sources
- Networking modes for a network of VMs : [documentation from virtualbox](https://www.virtualbox.org/manual/ch06.html)
- Presentation of a controller/agent setup over 2 vagrant VMs: [video](https://www.youtube.com/watch?v=JLnjMCRLcCo )
- Simple sample vagrantfile : [code](https://gitlab.com/vshn/demos/demo-k3s-in-vagrant/-/blob/master/Vagrantfile?ref_type=heads)
- Rather complex vagrantfile : [code](https://github.com/biggers/vagrant-kubernetes-by-k3s/blob/master/Vagrantfile)
- K3s over Alpine Linux : [article](https://draghici.net/2020/06/09/alpine-and-k3s-a-lightweight-kubernetes-experience/)
- Some more K3s over Alpine Linux : [article](https://teada.net/k3s-on-alpine-linux/)
