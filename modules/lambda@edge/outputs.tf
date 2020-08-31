output "arn" {
  value = concat(aws_lambda_function.this.*.arn, [""])[0]
}

output "qualified_arn" {
  value = concat(aws_lambda_function.this.*.qualified_arn, [""])[0]
}

output "version" {
  value = concat(aws_lambda_function.this.*.version, [""])[0]
}
