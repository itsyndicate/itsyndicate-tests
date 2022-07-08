variable "region" {
  type        = string
  description = "AWS region."
  default     = "eu-central-1"
}

variable "s3_id" {
  type = string
  description = "s3 id"
  default = "static1index-image.s3.eu-central-1.amazonaws.com"
}

variable "ssh_key_name" {
 type = string
 default = "ssh-key"
}
