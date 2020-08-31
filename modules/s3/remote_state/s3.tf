resource "aws_s3_bucket" "s3_tfstate" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  tags = {
    Cluster = var.cluster
    Service = var.service
  }
}
