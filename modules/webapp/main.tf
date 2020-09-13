module "cdn" {
  source                                    = "cloudposse/cloudfront-s3-cdn/aws"
  version                                   = "0.34.0"
  acm_certificate_arn                       = var.acm_certificate_arn
  aliases                                   = var.aliases
  cloudfront_origin_access_identity_iam_arn = var.origin_access_identity
  cloudfront_origin_access_identity_path    = var.origin_access_identity
  enabled                                   = var.create
  error_document                            = "index.html"
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
  index_document         = "index.html"
  logging_enabled        = var.logging_enabled
  name                   = var.service
  namespace              = var.name
  parent_zone_id         = var.hosted_zone_id
  stage                  = var.stage
  viewer_protocol_policy = "redirect-to-https"
  website_enabled        = true

  lambda_function_association = concat(
    [],
    var.lambda_for_csp_arn == "" ? [] : [{
      event_type   = "origin-response"
      include_body = false
      lambda_arn   = var.lambda_for_csp_arn
      }
  ])

  tags = {
    service = var.service
    stage   = var.stage
  }
}
