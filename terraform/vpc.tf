resource "aws_vpc" "main_backend" {
  cidr_block = "10.1.0.0/16"
  tags       = {
    Name = "main-backend"
  }
}

resource "aws_subnet" "public-1a" {
  cidr_block        = "10.1.0.0/24"
  vpc_id            = aws_vpc.main_backend.id
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1a"
  tags              = {
    Name = "public-eu-central-1"
  }
}

resource "aws_subnet" "private-1a" {
  cidr_block        = "10.1.1.0/24"
  vpc_id            = aws_vpc.main_backend.id
  availability_zone = "eu-central-1a"
  tags              = {
    Name = "private-eu-central-1"
  }
}
