terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_region" "region" {}

data "aws_lambda_function" "lambda" {
  function_name = local.function_name
}

data "aws_iam_role" "iam_role" {
  name = "${var.service}-${var.environment}-${data.aws_region.region.name}-lambdaRole"
}
