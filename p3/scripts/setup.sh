# Check if docker is installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed ✔"
    echo "$(docker --version)"
else
    echo "Docker is not installed. Installing..."

# Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo docker run hello-world
    if [ $? -eq 0 ]; then
        echo "Docker has been installed successfully."
    else
        echo "Failed to install Docker properly. Please retry."
        exit 1
    fi
fi

# Install kubectl
# Check if k3d is installed
if command -v k3d &> /dev/null; then
    echo "k3d and k3s are already installed ✔"
    echo "$(k3d --version)"
else
    # Install k3d with wget
    echo "k3d is not installed. Installing it now..."
    wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
    if [ $? -eq 0 ]; then
        echo "k3d has been installed successfully."
    else
        echo "Failed to install k3d. Please retry."
        exit 1
    fi
fi
# Install kubectl
# Check if kubectl is installed
if command -v kubectl &> /dev/null; then
    echo "kubectl is already installed ✔"
    echo "$(kubectl version --client | grep "Client Version")"
else
    # Download binary
    echo "kubectl is not installed. Installing it now..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    # Validate binary
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    # Install binary
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    if [ $? -eq 0 ]; then
        echo "kubectl has been installed successfully ✔"
    else
        echo "Failed to install kubectl. Please retry."
        exit 1
    fi
fi
# Install helm
# Check if helm is installed
if command -v helm &> /dev/null; then
    echo "helm is already installed ✔"
    echo "$(helm --version)"
else
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
    sudo apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm
    if [ $? -eq 0 ]; then
        echo "helm has been installed successfully ✔"
    else
        echo "Failed to install helm. Please retry."
        exit 1
    fi
fi
#sudo groupadd docker
# sudo usermod -a -G docker calle
