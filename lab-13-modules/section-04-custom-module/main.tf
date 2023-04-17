# Create S3 Bucket Resource
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags          = var.tags
  force_destroy = true
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}/*"
          ]
      }
  ]
}  
EOF
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": ""
    }
}]
EOF
}

