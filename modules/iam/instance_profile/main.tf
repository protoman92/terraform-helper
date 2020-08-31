locals {
  name = "${var.service}-${var.microservice}-${var.stage}"
}

resource "aws_iam_role" "role" {
  count = var.create ? 1 : 0
  name  = local.name

  assume_role_policy = <<-EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOT

  tags = {
    microservice = var.microservice
    service      = var.service
    stage        = var.stage
  }
}

resource "aws_iam_instance_profile" "profile" {
  count = var.create ? 1 : 0
  name  = local.name
  role  = concat(aws_iam_role.role.*.name, [""])[0]
}

resource "aws_iam_role_policy" "role_policy" {
  count  = var.create ? 1 : 0
  name   = local.name
  role   = concat(aws_iam_role.role.*.id, [""])[0]
  policy = var.role_policy
}

resource "aws_iam_role_policy_attachment" "attachment" {
  count      = var.create ? length(var.policy_arns) : 0
  policy_arn = element(var.policy_arns, count.index)
  role       = concat(aws_iam_role.role.*.name, list(""))[0]
}
