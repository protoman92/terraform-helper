output "forward_email" {
  value = local.forward_email
}

output "relay_email" {
  value = local.relay_email
}

output "ses_domain_identity_arn" {
  value = module.this.ses_domain_identity_arn
}
