variable "acm_certificate_arn" {
  type = string
}

variable "ami" {
  type = string
}

variable "create" {
  default = true
  type    = bool
}

variable "domain" {
  type = string
}

variable "ec2_instance_profile_name" {
  default = ""
  type    = string
}

variable "microservice" {
  type = string
}

variable "service" {
  type = string
}

variable "stage" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "zone_id" {
  type = string
}
