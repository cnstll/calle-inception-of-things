# inception-of-things

## About the project

### Part 1: K3s and Vagrant:

- Set up a personal virtual machine using Vagrant.
- Choose and configure your preferred Linux distribution.
- Lay the foundation for your Kubernetes journey.

### Part 2: K3s and Three Simple Applications:

- Explore K3s, a lightweight Kubernetes distribution.
- Deploy three simple applications within your Kubernetes environment.
- Gain hands-on experience in managing and scaling containerized applications.
### Part 3: K3d and Argo CD:

- Discover K3d, a tool designed to simplify Kubernetes cluster management.
- Learn how to leverage K3d for creating and managing Kubernetes clusters.
- Explore Argo CD, a continuous delivery tool for Kubernetes, and understand its role in the deployment process.

## About Vagrant
**Vagrant** is an open-source tool for managing and provisioning virtual machines for development and testing purposes.  
It provides a convenient way to create, configure, and manage virtualized development environments, making it easier  
to work on projects that require specific dependencies, configurations, or multiple machines.  

A **Vagrantfile** is the configuration file used to define the virtual machine(s) you want to create and how they should be provisioned.  
It is typically written in Ruby and serves as a blueprint for Vagrant to follow when creating and managing the VMs.  
  
A **Vagrant box** is a pre-configured, reusable virtual machine image that serves as a base for creating and provisioning virtual machines using Vagrant. Boxes are designed to make it easy to distribute and share development environments, ensuring that developers work on the same foundation with a consistent setup.   

## About k3s
**k3s** is a lightweight version of k8s relying on a sql light db instead of etcd.  
k3s is used for edge applciations or IoT deployments.  
K3s as k8s use kubectl for interacting with the cluster.  

## About k3d
**k3d** is a ligthweight wrapper around k3s that containerize a cluster using Docker.  


## About Argo CD  
**Argo CD** is a GitOps tool used for continuous development.  
The particularity of Argo CD is that it is deployed within the cluster which cut down on setup complexity as you don't have to set up access rights.  

## Sources
- Networking modes for a network of VMs : [documentation from virtualbox](https://www.virtualbox.org/manual/ch06.html)
- Presentation of a controller/agent setup over 2 vagrant VMs: [video](https://www.youtube.com/watch?v=JLnjMCRLcCo )
- Simple sample vagrantfile : [code](https://gitlab.com/vshn/demos/demo-k3s-in-vagrant/-/blob/master/Vagrantfile?ref_type=heads)
- Rather complex vagrantfile : [code](https://github.com/biggers/vagrant-kubernetes-by-k3s/blob/master/Vagrantfile)
- K3s over Alpine Linux : [article](https://draghici.net/2020/06/09/alpine-and-k3s-a-lightweight-kubernetes-experience/)
- Some more K3s over Alpine Linux : [article](https://teada.net/k3s-on-alpine-linux/)
