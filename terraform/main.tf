#----------------------------------------------------------
# My Terraform
#
# Dev project
#
# Made by "Bogdan Pashkevich"
#----------------------------------------------------------

resource "aws_key_pair" "key_pair" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}
