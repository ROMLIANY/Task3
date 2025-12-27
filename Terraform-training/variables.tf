variable "network_name" {
  type    = string
  default = "app-network"
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
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

variable "app_version" {
  type = string
  default = "v1"
}

variable "active_color" {
  type    = string
  default = "blue"              # choose color, green or blue
  validation {
    condition     = contains(["blue", "green"], var.active_color)
    error_message = "active_color must be 'blue' or 'green'."
  }

}