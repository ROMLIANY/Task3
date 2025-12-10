variable "instance_count" {
  type    = number
  default = 1
}

variable "container_name" {
  type    = string
  default = "web"
}

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "external_port" {
  type    = number
  default = 8080
}

variable "network_name" {
  type    = string
  default = "webnet"
}
