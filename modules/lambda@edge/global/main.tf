data "aws_lambda_function" "this" {
  function_name = "futurama-lambda-inject-security-header"
  qualifier     = "1"
}
