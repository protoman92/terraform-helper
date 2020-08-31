data "aws_iam_policy_document" "backend_policy" {
  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.s3_tfstate.bucket}"]
  }

  statement {
    actions = ["s3:GetObject", "s3:PutObject"]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.s3_tfstate.bucket}/${var.state_key}",
    ]
  }
}
