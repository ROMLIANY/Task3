variable "instance_count" {
  type = number
}

variable "external_port" {
  type = number
}

variable "network_name" {
  type = string
}

variable "labels" {
  type = map(string)
}
