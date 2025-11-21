# ---------- EC2 for dev environment ----------

# Use the default VPC (we'll build custom VPC tomorrow)
data "aws_vpc" "default" {
  default = true
}

# Get the latest Amazon Linux 2023 AMI in this region
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Security group for web server
resource "aws_security_group" "web_sg" {
  name        = "${local.name_prefix}-web-sg"
  description = "Web security group for ${local.name_prefix}"
  vpc_id      = data.aws_vpc.default.id

  # SSH from anywhere (you can later restrict this to your IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow HTTP from anywhere (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-web-sg"
    }
  )
}

# EC2 instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name      = "terraform-dev-key"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
#!/bin/bash
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "Hello from Sri's Terraform EC2!" > /var/www/html/index.html
EOF

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-web-instance"
    }
  )
}
