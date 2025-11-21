variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "bucket_suffix" {
  type    = string
  default = "demo-bucket"
}

variable "owner" {
  type    = string
  default = "Sri"
}
