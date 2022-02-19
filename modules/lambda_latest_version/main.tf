terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_lambda_alias" "this" {
  count         = var.enabled ? 1 : 0
  function_name = var.function_name
  name          = var.latest_alias
}
