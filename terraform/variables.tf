
variable "domain_link" {
  default = "webxdata.com"
}

variable "env" {
  default = "dev"
}

variable "project_name" {
  default = "Webxdata"
}

variable "owner" {
  default = "Bogdan Pashkevich"
}

variable "region" {
  description = "Please Enter AWS Region to deploy Server"
  type        = string
  default     = "eu-central-1"
}

variable "ec2_size" {
  description = "Enter Instance Type"
  default = {
    "prod"    = "t3.medium"
    "dev"     = "t3.micro"
    "staging" = "t2.small"
  }
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "8080", "22"]
  }
}

variable "ssh_key_name" {
  description = "The SSH Key Name"
  type        = string
  default     = "webxdata_ssh_key"
}

variable "ssh_public_key_path" {
  description = "The local path to the SSH Public Key"
  type        = string
  default     = "/home/webxdata/.ssh/id_rsa.pub"
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
#  type        = map
  default     = {
  Owner       = "Bogdan Pashkevich"
  Project     = "Webxdata"
  CostCenter  = "10"
  Environment = "dev"
  }
}

