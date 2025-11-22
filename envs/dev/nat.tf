# Elastic IP for NAT Gateway (in public subnet)
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-eip"
    }
  )
}
# NAT Gateway in the public subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_az1.id  # your public subnet

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-gw"
    }
  )
}
# Private route table (for private subnets)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # Route for internet-bound traffic from private subnets via NAT
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-rt"
    }
  )
}

# Associate private subnet in AZ1 with private route table
resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private.id
}

# Associate private subnet in AZ2 with private route table
resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private.id
}
