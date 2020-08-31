variable "create" {
  default = true
  type    = bool
}

variable "microservice" {
  type = string
}

variable "policy_arns" {
  default = []
  type    = list(string)
}

variable "role_policy" {
  type = string
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}
