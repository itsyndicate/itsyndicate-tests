sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
sudo chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose version
docker-compose up -d