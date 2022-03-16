variable "domain" {
  type = string
}

variable "email" {
  type = string
}

variable "enabled" {
  default     = true
  description = "Whether to create resources"
  type        = bool
}

variable "forward_email" {
  default = null
  type    = string
}

variable "relay_email" {
  default = null
  type    = string
}

variable "region" {
  default = "us-east-1"
  type    = string
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}

variable "tags" {
  default     = null
  description = "The tags to attach to the resources"
  type        = map(string)
}

locals {
  forward_email = coalesce(var.forward_email, "admin@${var.domain}")
  relay_email   = coalesce(var.relay_email, "admin@${var.domain}")
}
