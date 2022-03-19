terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "this" {
  source                                    = "registry.terraform.io/cloudposse/cloudfront-s3-cdn/aws"
  version                                   = "0.82.3"
  acm_certificate_arn                       = var.acm_certificate_arn
  aliases                                   = var.aliases
  allow_ssl_requests_only                   = false
  cloudfront_origin_access_identity_iam_arn = var.origin_access_identity
  cloudfront_origin_access_identity_path    = var.origin_access_identity
  compress                                  = true
  dns_alias_enabled                         = length(compact(var.aliases)) > 0
  enabled                                   = var.enabled
  error_document                            = "index.html"
  index_document                            = "index.html"
  logging_enabled                           = var.logging_enabled
  name                                      = var.name
  namespace                                 = var.namespace
  parent_zone_id                            = var.hosted_zone_id
  stage                                     = var.stage
  tags                                      = coalesce(var.tags, {})
  versioning_enabled                        = var.versioning_enabled
  viewer_protocol_policy                    = "redirect-to-https"
  website_enabled                           = true

  custom_error_response = [{
    error_caching_min_ttl = local.error_caching_min_ttl
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    }, {
    error_caching_min_ttl = local.error_caching_min_ttl
    error_code            = 500
    response_code         = 200
    response_page_path    = "/index.html"
  }]

  forward_header_values = tolist(toset(concat(var.forward_header_values, [
    "Access-Control-Request-Headers",
    "Access-Control-Request-Method",
    "Origin"
  ])))

  lambda_function_association = concat(
    [],
    var.lambda_for_csp_arn == "" ? [] : [
      {
        event_type   = "origin-response"
        include_body = false
        lambda_arn   = var.lambda_for_csp_arn
      }
    ]
  )
}
