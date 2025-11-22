# Get list of available AZs in this region
data "aws_availability_zones" "available" {
  state = "available"
}

# Public subnet in AZ1
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id   # <-- use your VPC TF name here
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true              # instances get public IP by default

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-az1"
    }
  )
}

# Private subnet in AZ1
resource "aws_subnet" "private_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-az1"
    }
  )
}

# Private subnet in AZ2
resource "aws_subnet" "private_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-az2"
    }
  )
}
