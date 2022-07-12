#!/bin/bash

while [ ! -f /tmp/docker-end.txt ]
do
   echo "Docker installation in progress ..."
  sleep 2 # or less like 0.2
done
echo "Docker installation finished, starting docker-compose build .."
mkdir /home/ubuntu/.docker
sudo cp /home/ubuntu/docker_config.json /home/ubuntu/.docker/config.json
sudo mkdir /root/.docker
sudo cp /home/ubuntu/docker_config.json /root/.docker/config.json
aws ecr get-login --region eu-central-1

sudo docker-compose up -d