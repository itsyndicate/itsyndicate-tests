resource "aws_s3_bucket" "static" {
  bucket = "static1index-image"
  website {
    index_document = "base.html"
  }

}