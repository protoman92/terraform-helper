module "ses_lambda_forwarder" {
  source       = "cloudposse/ses-lambda-forwarder/aws"
  version      = "0.8.0"
  artifact_url = "file:///${path.cwd}/${path.module}/document/ses_forward_email_lambda.zip"
  domain       = var.domain
  forward_emails = {
    "${local.forward_email}" = list(var.email)
  }
  lambda_runtime = "nodejs12.x"
  namespace      = var.service
  region         = var.region
  relay_email    = local.relay_email
  stage          = var.stage
}
