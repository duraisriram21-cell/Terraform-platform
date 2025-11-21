variable "aws_region" {
  description = "AWS region for this environment"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name of the project for naming resources"
  type        = string
  default     = "terraform-platform"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
