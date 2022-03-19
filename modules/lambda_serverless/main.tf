terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_region" "this" {
  count = var.enabled ? 1 : 0
}

data "aws_lambda_function" "this" {
  count         = var.enabled ? 1 : 0
  function_name = join("-", compact([var.service, var.environment, var.function_name]))
}

data "aws_iam_role" "this" {
  count = var.enabled ? 1 : 0

  name = join("-", compact([
    var.service,
    var.environment,
    one(data.aws_region.this.*.name),
    "lambdaRole"
  ]))
}

module "latest_version" {
  source        = "../lambda_latest_version"
  enabled       = alltrue([var.enabled, var.enable_latest_version_qualifier, var.latest_version_alias != null])
  function_name = one(data.aws_lambda_function.this.*.function_name)
  latest_alias  = var.latest_version_alias
}

data "aws_api_gateway_rest_api" "this" {
  count = var.enabled ? 1 : 0
  name  = join("-", compact([var.environment, var.service]))
}

