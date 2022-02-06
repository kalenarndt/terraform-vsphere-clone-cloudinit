#!/bin/bash
# Prepares VMs for TFCB

# Docker Dependecies
echo '> Installing Docker Dependecies'
apt install -y ca-certificates curl gnupg lsb-release

echo '> Installing Docker and Docker-Compose'
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo '> Setting up Permissions'
