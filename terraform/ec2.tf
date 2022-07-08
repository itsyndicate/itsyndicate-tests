resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCRi60gvLSPCXVyhmHw7cCLtOjT/ONRBUA4NGB3cjxVRRBiXW+lllfps3gGnt5jo0QyP9UnDSPqgw4xY1hx4Z4hl6u6aOQEeXa9HwVJ9iZoMMn0YlrC+8TS+p6zN3BeQQRSiX8N8NhVgvDCoARr6mD97uGtHcgjAMeWRHM5Nt6dkCGtkZ7euarNAE6mPOTOmI4mHJGtzGM3/GBi1r+F7KGkUs0djAQnEsglNM9LLV/3cQvC01NBkIvk9Ll7su8eooS9yE7owp+LEkSU9ooA3LRG/3JXBcpBqF/YkAJoCgrZofJ9xhd6KhQOdnTtAysjs6ZTjr7aXJqp/Mcq+Bq+BaqvEomrcRhtxUkvB8t1nhjfPBOa03kF6KABGeiNWBzN1OpTpoFj4Rb9joxxoXu4AvgkI94bELzB2X1Ew/3mr2+Z+vLMZM8qGvVh7y9U4X/yr2h7bA9o+6vHLVIfdkzyfMQLARWy620GsXj2cjwVWki0XZ/Ck0weuOHPYy7dBpEQ1M0= inemyrovsk@ThinkCentre-M73"
}

resource "aws_instance" "backend" {
  ami           = "ami-035e90af11365cc27"
  instance_type = "t2.micro"
  provisioner "file" {
    source      = "../app"
    destination = "app"
  }
  provisioner "file" {
    source      = "../djangoProject"
    destination = "djangoProject"
  }
  provisioner "file" {
    source      = "../docker-compose.yml"
    destination = "docker-compose.yml"
  }
  user_data = <<EOF
apt-get update -y
apt-get install -y docker-compose
docker-compose up
EOF

  tags = {
    Name = "django-backend"
  }
}

