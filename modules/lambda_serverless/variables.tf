variable "enabled" {
  default     = true
  description = "Whether to fetch remote resources"
  type        = bool
}

variable "enable_latest_version_qualifier" {
  default     = true
  description = "Whether to get latest version qualifier, assuming that the lambda has an alias for the latest version"
  type        = bool
}

variable "environment" {
  description = "The environment, defined as \"provider.stage\"."
  type        = string
}

variable "function_name" {
  description = "The name of the function, defined as an element of the \"functions\" array."
  type        = string
}

variable "latest_version_alias" {
  default     = null
  description = "The alias of the latest version, provided that enable_latest_version_qualifier=true"
  type        = string
}

variable "service" {
  description = "The name of the service."
  type        = string
}
