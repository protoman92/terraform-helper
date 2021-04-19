variable "domain" {
  type = string
}

variable "email" {
  type = string
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

locals {
  forward_email = var.forward_email == null ? "admin@${var.domain}" : var.forward_email
  relay_email   = var.relay_email == null ? "admin@${var.domain}" : var.relay_email
}
