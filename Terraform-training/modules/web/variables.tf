variable "instance_count" {
  type = number
}

variable "network_name" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "ports" {
  description = "List of port mappings"
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
}