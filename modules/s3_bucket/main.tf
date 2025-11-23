# Child module: actually creates the S3 bucket

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}
