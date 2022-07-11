
/*
# Start a container
resource "docker_container" "ubuntu" {
  name  = "foo"
  image = docker_image.ubuntu.latest
}

# Find the latest Ubuntu precise image.
resource "docker_image" "ubuntu" {
  name = "ubuntu:precise"
}


provider "docker" {
  host     = "ssh://ubuntu@${aws_eip.my_static_ip.public_ip}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

# Create a container
resource "docker_container" "foo" {
  image = module.aws_ecr_docker_image.repository_url.latest
  name  = "django2"
}



*/