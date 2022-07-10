# Set the required provider and versions

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["/home/webxdata/.aws/creds"]
  profile = "webxdata"
}

provider "aws" {
  region = var.region
  shared_credentials_files = ["/home/webxdata/.aws/creds"]
  profile = "webxdata"
  alias = "germany"
}

provider "docker" {
}
