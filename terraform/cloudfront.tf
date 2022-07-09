resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = var.s3_id
    origin_id           = "static1index-image.s3-website.eu-central-1.amazonaws.com"
  }
  is_ipv6_enabled = true
  enabled         = true


  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD",]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "http://static1index-image.s3-website.eu-central-1.amazonaws.com"
    compress               = true
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true

  }
  tags = {
    "Environment" = "production"
  }
  tags_all = {
    "Environment" = "production"
  }

}