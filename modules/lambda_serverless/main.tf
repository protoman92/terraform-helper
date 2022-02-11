terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_region" "region" {
  count = var.enabled ? 1 : 0
}

data "aws_lambda_function" "lambda" {
  count         = var.enabled ? 1 : 0
  function_name = join("-", [var.service, var.environment, var.function])
}

data "aws_iam_role" "iam_role" {
  count = var.enabled ? 1 : 0

  name = join("-", compact([
    var.service,
    var.environment,
    one(data.aws_region.region.*.name),
    "lambdaRole"
  ]))
}
