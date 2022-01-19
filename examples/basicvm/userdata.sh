#!/bin/bash
# Basic example of adding a repo and installing Consul-Enterprise in a VM.
set -v
echo '> Adding HashiCorp Linux Repository'
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo '> Installing Consul Enterprise'
apt install -y consul-enterprise

echo '> Done!'
