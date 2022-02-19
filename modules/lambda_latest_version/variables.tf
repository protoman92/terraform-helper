variable "enabled" {
  default     = true
  description = "Whether to create resources"
  type        = bool
}

variable "function_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "latest_alias" {
  description = "The alias to use to denote the latest version"
  type        = string
}
