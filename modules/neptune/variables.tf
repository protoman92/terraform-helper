variable "create" {
  default = true
  type    = bool
}

variable "domain" {
  type = string
}

variable "enable_iam_authentication" {
  default = true
  type    = bool
}

variable "instance_class" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "microservice" {
  type = string
}

variable "port" {
  default = 8182
  type    = number
}

variable "preferred_backup_window" {
  default = "07:00-09:00"
  type    = string
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "zone_id" {
  type = string
}
