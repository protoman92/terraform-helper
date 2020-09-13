variable "acm_certificate_arn" {
  type = string
}

variable "aliases" {
  type = list(string)
}

variable "create" {
  default = true
  type    = bool
}

variable "hosted_zone_id" {
  type = string
}

variable "lambda_for_csp_arn" {
  type = string
}

variable "logging_enabled" {
  default = false
  type    = bool
}

variable "name" {
  type = string
}

variable "origin_access_identity" {
  type = string
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}

locals {
  error_caching_min_ttl = 300
}
