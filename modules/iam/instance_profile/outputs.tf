output "profile_name" {
  value = concat(aws_iam_instance_profile.profile.*.name, [""])[0]
}

output "role_id" {
  value = concat(aws_iam_role.role.*.id, [""])[0]
}

output "role_name" {
  value = concat(aws_iam_role.role.*.name, [""])[0]
}
