variable "instance_count" {
  type    = number
  default = 1
}

variable "network_name" {
  type    = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "ports" {
  description = "List of port mappings"
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
}

# New variable for container base name
variable "container_base_name" {
  type    = string
  default = "nginx"
}