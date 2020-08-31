output "role_arn" {
  value = concat(aws_iam_role.iam_role.*.arn, [""])[0]
}

output "role_name" {
  value = concat(aws_iam_role.iam_role.*.name, [""])[0]
}
