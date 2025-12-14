variable "network_name" {
  type    = string
  default = "app-network"
}

variable "db_user" {
  type    = string
  default = "root"
}

variable "db_password" {
  type    = string
  default = "password123"
}

variable "external_port" {
  type    = number
  default = 5000
}

variable "external_port_web" {
  type    = number
  default = 8080
}

variable "instance_count" {
  type    = number
  default = 2
}
