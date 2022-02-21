variable "acm_certificate_arn" {
  default     = ""
  description = "Corresponds to the acm_certificate_arn property in the source module"
  type        = string
}

variable "aliases" {
  default = []
  type    = list(string)
}

variable "enabled" {
  default     = true
  description = "Whether to create resources"
  type        = bool
}

variable "forward_header_values" {
  default = []
  type    = list(string)
}

variable "hosted_zone_id" {
  default = ""
  type    = string
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
  description = "Corresponds to the name property in the source module"
  type        = string
}

variable "namespace" {
  description = "Corresponds to the namespace property in the source module"
  type        = string
}

variable "origin_access_identity" {
  default = ""
  type    = string
}

variable "stage" {
  description = "Corresponds to the stage property in the source module"
  type        = string
}

variable "tags" {
  default     = null
  description = "Corresponds to the tags property in the source module"
  type        = map(string)
}

variable "versioning_enabled" {
  default = false
  type    = bool
}

locals {
  error_caching_min_ttl = 300
}
