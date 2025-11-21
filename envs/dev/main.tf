# ----------------------------
# S3 bucket for demo (dev env)
# ----------------------------
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "${local.name_prefix}-demo-bucket"

  tags = local.common_tags
}
