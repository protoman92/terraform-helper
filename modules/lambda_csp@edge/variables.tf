variable "connect_source" {
  type = list(string)
}

variable "create" {
  default = true
  type    = bool
}

variable "font_source" {
  default = []
  type    = list(string)
}

variable "frame_source" {
  default = []
  type    = list(string)
}

variable "image_source" {
  type = list(string)
}

variable "service" {
  type = string
}

variable "script_source" {
  default = []
  type    = list(string)
}

variable "script_source_elem" {
  default = []
  type    = list(string)
}

variable "stage" {
  type = string
}

variable "style_source" {
  default = []
  type    = list(string)
}

variable "style_source_elem" {
  default = []
  type    = list(string)
}

variable "x_frame_options" {
  default = "DENY"
  type    = string
}
