sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo groupadd docker
sudo gpasswd -a username docker
sudo usermod -aG docker $USER
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo service docker restart
docker-compose up -d