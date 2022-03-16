terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "this" {
  source         = "registry.terraform.io/cloudposse/ses-lambda-forwarder/aws"
  version        = "0.11.0"
  artifact_url   = "file:///${path.cwd}/${path.module}/document/ses_forward_email_lambda.zip"
  enabled        = var.enabled
  domain         = var.domain
  lambda_runtime = "nodejs12.x"
  namespace      = var.service
  region         = var.region
  relay_email    = local.relay_email
  stage          = var.stage
  tags           = var.tags

  forward_emails = {
    (local.forward_email) = compact([var.email])
  }
}
