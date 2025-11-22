# --------- VPC for dev environment ---------

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"   # Big network range for this VPC
  enable_dns_support   = true           # So instances can resolve DNS
  enable_dns_hostnames = true           # So instances get DNS names

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc"
    }
  )
}
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-2.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private.id
  ]

  tags = merge(
    local.common_tags,
    { Name = "${local.name_prefix}-s3-endpoint" }
  )
}
