variable "environment" {
  description = "The environment, defined as \"provider.stage\"."
  type        = string
}

variable "function" {
  description = "The name of the function, defined as an element of the \"functions\" array."
}

variable "service" {
  description = "The name of the service."
  type        = string
}

locals {
  function_name = "${var.service}-${var.environment}-${var.function}"
}
