########## Network ACLs for dev VPC ##########

# Public subnet NACL – allow all in/out (you can tighten later)
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.public_az1.id]

  # Inbound - allow all
  ingress {
    rule_no    = 100
    protocol   = "-1"         # all protocols
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # Outbound - allow all
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-nacl"
    }
  )
}

# Private subnets NACL – only allow inside-VPC traffic + internet via NAT
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id,
  ]

  # Inbound – allow from inside VPC CIDR only
  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "10.0.0.0/16"   # your VPC range
    from_port  = 0
    to_port    = 0
  }

  # Outbound – allow to anywhere (will actually go out via NAT GW)
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-nacl"
    }
  )
}
