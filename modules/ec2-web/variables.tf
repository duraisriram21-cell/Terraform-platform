variable "vpc_id" {
  description = "VPC ID where EC2 and SG will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming EC2 and SG"
  type        = string
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script for EC2"
  type        = string
  default     = ""
}
