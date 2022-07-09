sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo groupadd docker
sudo gpasswd -a username docker
sudo usermod -aG docker ec2-user
sudo chmod 777 /var/run/docker.sock
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo service docker restart
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 138941284341.dkr.ecr.eu-central-1.amazonaws.com
docker-compose up -d