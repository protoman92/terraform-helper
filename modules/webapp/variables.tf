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

variable "forward_header_values" {
  default = []
  type    = list(string)
}

variable "hosted_zone_id" {
  type = string
}

variable "lambda_for_csp_arn" {
  default = ""
  type    = string
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

variable "versioning_enabled" {
  default = false
  type    = bool
}

locals {
  error_caching_min_ttl = 300
}
