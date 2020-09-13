resource "aws_lambda_function" "this" {
  count            = var.create ? 1 : 0
  filename         = var.filename
  function_name    = "${var.service}-${var.stage}-${var.function_name}"
  handler          = var.handler
  publish          = true
  role             = var.iam_role_arn
  runtime          = var.runtime
  source_code_hash = var.source_code_hash

  tags = {
    service = var.service
    stage   = var.stage
  }
}

resource "aws_lambda_permission" "allow_cloudfront" {
  count         = var.create ? 1 : 0
  depends_on    = [aws_lambda_function.this]
  statement_id  = "AllowExecutionFromCloudFront"
  action        = "lambda:GetFunction"
  function_name = concat(aws_lambda_function.this.*.function_name, [""])[0]
  principal     = "edgelambda.amazonaws.com"
}
