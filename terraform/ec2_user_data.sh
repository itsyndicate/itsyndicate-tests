#!/bin/bash
sudo apt update &&
sudo apt-get install -y git curl wget awscli &&
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose &&
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose &&
docker-compose --version &&
curl -fsSL https://get.docker.com -o get-docker.sh &&
sudo bash get-docker.sh &&
sudo usermod -aG docker ubuntu &&
echo "docker" > /tmp/docker-end.txt
mkdir /home/ubuntu/.docker/
mkdir /root/.docker