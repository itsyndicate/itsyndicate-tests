#----------------------------------------------------------
# My Terraform
#
# Dev project
#
# Made by "Bogdan Pashkevich"
#----------------------------------------------------------

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

resource "aws_key_pair" "key_pair" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}
