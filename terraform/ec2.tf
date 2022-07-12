
resource "aws_key_pair" "key_pair" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}

resource "aws_instance" "my_server" {
  provider                 = aws.germany
  ami                      = data.aws_ami.latest_ubuntu.id
  instance_type = lookup(var.ec2_size, var.env)
  vpc_security_group_ids   = [aws_security_group.my_server.id]
  monitoring               = var.enable_detailed_monitoring
  key_name                 = aws_key_pair.key_pair.key_name
  user_data              = file("ec2_user_data.sh")

  tags                     = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server Build by Terraform" })

  lifecycle {
    create_before_destroy  = false
  }

provisioner "file" {
    source      = "../docker.sh"
    destination = "/home/ubuntu/docker.sh"
  }

  provisioner "file" {
    source      = "/home/webxdata/.docker/config.json"
    destination = "/home/ubuntu/docker_config.json"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = aws_instance.my_server.public_ip
    private_key = file(var.ssh_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "git clone https://github.com/domorelivelonger/itsyndicate-tests.git",
      "cd itsyndicate-tests",
      "sed -i 's@domorelivelonger/django_test@${module.aws_ecr_docker_image.repository_url}@g' docker-compose.yml",
      "cp .env_sample .env",
      "cp .env.db_sample .env.db",
      "sed -i 's@eu-central-1@${var.region}@g' /home/ubuntu/docker.sh",
      "bash /home/ubuntu/docker.sh"
    ]
  }

  depends_on = [module.aws_ecr_docker_image]

}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name      = "name"
    values    = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_server.id
  tags     = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server IP" })

}

resource "aws_security_group" "my_server" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server SecurityGroup" })
}
