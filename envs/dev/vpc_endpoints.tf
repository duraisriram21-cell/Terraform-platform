# Get current region (us-west-2, etc.)
data "aws_region" "current" {}
# Security group for Interface VPC Endpoints (SSM, EC2Messages, SSMMessages)
resource "aws_security_group" "vpce_endpoints_sg" {
  name        = "${local.name_prefix}-vpce-endpoints-sg"
  description = "SG for VPC Interface Endpoints (SSM, EC2Messages, SSMMessages)"
  vpc_id      = aws_vpc.main.id  # use your VPC resource name here

  # Allow HTTPS from inside the VPC
  ingress {
    description = "Allow HTTPS from VPC CIDR"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # Allow all outbound (endpoints talk back to SSM service)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpce-endpoints-sg"
    }
  )
}
