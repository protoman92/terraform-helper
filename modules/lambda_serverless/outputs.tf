output "lambda_arn" {
  value = data.aws_lambda_function.lambda.arn
}

output "iam_role_arn" {
  value = data.aws_iam_role.iam_role.arn
}
