locals {
  # Standard naming pattern like: terraform-platform-dev
  name_prefix = "${var.project_name}-${var.environment}"

  # Common tags applied to most resources
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = "Sri"
    ManagedBy   = "Terraform"
  }
}
