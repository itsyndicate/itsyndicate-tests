module "my_site" {
  source = "github.com/pirxthepilot/terraform-aws-static-site?ref=v0.0.1"
  name   = "my_site"

  domain               = "${var.domain_link}"
  subdomains           = ["www"]
  route53_zone_id      = aws_route53_zone.domain_link_public_zone.id
  block_ofac_countries = true

  cache_ttl = {
    min     = 0
    default = 14400
    max     = 86400
  }
}