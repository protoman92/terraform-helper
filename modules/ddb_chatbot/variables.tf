variable "create" {
  type = bool
}

variable "read_capacity" {
  default = 25
  type    = number
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}

variable "ttl_enabled" {
  default = true
  type    = bool
}

variable "write_capacity" {
  default = 25
  type    = number
}
