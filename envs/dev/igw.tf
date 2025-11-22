# Internet Gateway for dev VPC
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.main.id  # ⬅️ change 'main' if your VPC name is different

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-igw"
    }
  )
}
# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id  # same VPC as above

  # Route all Internet traffic out via the IGW
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-rt"
    }
  )
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}
