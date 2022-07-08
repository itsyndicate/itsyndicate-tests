resource "aws_s3_bucket" "static" {
  bucket = "static1index-image"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::static1index-image/*"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::138941284341:user/Sadmin"
      },
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::static1index-image/*",
        "arn:aws:s3:::static1index-image"
      ]
    }
  ]
}
EOF
}