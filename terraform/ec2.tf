resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "ssh-key.pem"
  file_permission = 0400
}
resource "aws_key_pair" "ssh_key_pair" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}
output "ssh-key-private" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

resource "aws_instance" "backend" {
  ami                         = "ami-0c9354388bb36c088"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-1a.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.backend.id]
  key_name                    = aws_key_pair.ssh_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.backend.id]
  user_data                   = <<EOF

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt-get install -y docker-compose
EOF

  tags = {
    Name = "django-backend"
  }
  depends_on = [aws_security_group.backend, aws_key_pair.ssh_key_pair]
}

resource "null_resource" "copy_files" {
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y git curl",
      "git clone https://github.com/inemyrovsk/itsyndicate-tests.git",
      "cd itsyndicate-tests",
      "bash deploy.sh",
      "pwd",
    ]
  }

  connection {
    host        = aws_instance.backend.public_ip
    type        = "ssh"
    user        = "ubuntu"
    port        = 22
    private_key = tls_private_key.ssh_key.private_key_pem
    agent       = "false"
  }
}