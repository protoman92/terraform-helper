output "lambda_arn" {
  value = one(data.aws_lambda_function.lambda.*.arn)
}

output "iam_role_arn" {
  value = one(data.aws_iam_role.iam_role.*.arn)
}

output "iam_role_name" {
  value = one(data.aws_iam_role.iam_role.*.name)
}
