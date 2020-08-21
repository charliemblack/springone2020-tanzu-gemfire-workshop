#!/usr/bin/env bash
# Disable exit on non 0
set +e
echo "export KUBECONFIG=~/.kube/config" >> ~/.profile
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64
chmod +x ./kind
mkdir -p .local/bin
mv kind .local/bin/
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv kubectl .local/bin/
curl -L https://k14s.io/install.sh | sudo bash
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
curl https://get.docker.com | sudo bash
# sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
sudo snap install k9s
mkdir ~/.k9s
