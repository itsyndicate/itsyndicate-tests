sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo yum install -y python3
sudo yum install -y python3-pip
sudo pip3 install docker-compose
#sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
#wait 10
#sudo chmod +x /usr/local/bin/docker-compose
#sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
pwd
wait 10