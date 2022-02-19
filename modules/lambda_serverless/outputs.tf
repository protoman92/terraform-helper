output "lambda_arn" {
  value = one(data.aws_lambda_function.this.*.arn)
}

output "lambda_function_name" {
  value = one(data.aws_lambda_function.this.*.function_name)
}

output "lambda_qualified_arn" {
  value = one(data.aws_lambda_function.this.*.qualified_arn)
}

output "lambda_latest_qualified_arn" {
  value = join(":", compact([one(data.aws_lambda_function.this.*.arn), module.latest_version.function_version]))
}

output "iam_role_arn" {
  value = one(data.aws_iam_role.this.*.arn)
}

output "iam_role_id" {
  value = one(data.aws_iam_role.this.*.id)
}

output "iam_role_name" {
  value = one(data.aws_iam_role.this.*.name)
}
