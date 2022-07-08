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

resource "aws_instance" "backend" {
  ami                         = "ami-0c9354388bb36c088"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-1a.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.backend.id]
  key_name                    = aws_key_pair.ssh_key_pair.key_name
  user_data                   = <<EOF
apt-get update -y
apt install -y git
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
apt-get install -y docker-compose
EOF

  tags = {
    Name = "django-backend"
  }
  depends_on = [aws_security_group.backend, aws_key_pair.ssh_key_pair, null_resource.copy_files]
}

resource "null_resource" "copy_files" {
  provisioner "remote-exec" {
 inline = ["apt install git -y",
    "git clone https://github.com/inemyrovsk/itsyndicate-tests.git",
    "cd itsyndicate-tests",
    "rm -rf .git",
    "docker-compose up -d",
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