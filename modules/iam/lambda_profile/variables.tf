variable "create" {
  default = true
  type    = bool
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}

locals {
  name = "${var.service}-lambda"
}