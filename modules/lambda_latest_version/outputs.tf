output "function_version" {
  value = one(data.aws_lambda_alias.this.*.function_version)
}
