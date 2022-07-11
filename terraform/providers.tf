# Set the required provider and versions

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "eu-central-1"
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
