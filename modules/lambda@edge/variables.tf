variable "create" {
  default = true
  type    = bool
}

variable "filename" {
  type = string
}

variable "handler" {
  type = string
}

variable "iam_role_arn" {
  type = string
}

variable "function_name" {
  type = string
}

variable "runtime" {
  type = string
}

variable "service" {
  type = string
}

variable "source_code_hash" {
  default = null
  type    = string
}

variable "stage" {
  type = string
}
