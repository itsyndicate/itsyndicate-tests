#----------------------------------------------------------
# My Terraform
#
# Test project
#
# Made by "Bogdan Pashkevich"
#----------------------------------------------------------


resource "aws_route53_zone" "domain_link_public_zone" {
  name = var.domain_link
  comment = "${var.domain_link} public zone"
  provider = aws
}

resource "aws_route53_record" "main_A_record" {
  zone_id = aws_route53_zone.domain_link_public_zone.zone_id
  name    = "${var.domain_link}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.my_static_ip.public_ip]
}