sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo dnf install python3
sudo python3 -m pip install -U pip
python3 -m pip install docker-compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose up -d