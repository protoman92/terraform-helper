variable "connect_source" {
  type = list(string)
}

variable "create" {
  default = true
  type    = bool
}

variable "image_source" {
  type = list(string)
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}
