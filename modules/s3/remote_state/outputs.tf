output "s3_bucket" {
  description = "The S3 bucket"
  value       = aws_s3_bucket.s3_tfstate.bucket
}

output "s3_state_key" {
  description = "The key that points to the state in the S3 bucket"
  value       = var.state_key
}

