#output "demo_bucket_name" {
# description = "Name of the S3 bucket created in dev"
# value       = aws_s3_bucket.demo_bucket.bucket
#}
# EC2 public IP for dev environment
output "dev_web_instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the dev web EC2 instance"
}
output "dev_web_instance_private_ip" {
  value       = aws_instance.web.private_ip
  description = "Private IP of the dev web EC2 instance"
}


