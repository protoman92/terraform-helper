variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "cluster" {
  description = "The cluster type"
  type        = string
}

variable "region" {
  description = "The region of the S3 bucket"
  type        = string
}

variable "service" {
  description = "The name of the service"
  type        = string
}

variable "state_key" {
  default     = "terraform"
  description = "The key path to store TF state"
  type        = string
}
