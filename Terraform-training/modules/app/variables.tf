variable "network_name" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "env_vars" {
  type        = map(string)
  description = "Environment variables for app container"
}

variable "instance_count" {
  type    = number
  default = 1
  validation {
    condition     = var.instance_count > 0
    error_message = "instance_count must be greater than 0."
  }
}

variable "external_port" {
  type    = number
  default = 5000
  validation {
    condition     = var.external_port >= 1024 && var.external_port <= 65535
    error_message = "external_port must be between 1024 and 65535."
  }
}