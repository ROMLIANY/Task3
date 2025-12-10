variable "container_name" {
    type      = srting
    default   = "my-nginx"
    description = "The name of the Nginx container"
}

variable "external_port" {
  type        = number
  default     = 8080
  description = "Port exposed from the container"
}

variable "image_tag" {
  type        = srting
  default     = "latest"
  description = "Tag of the Nginx Docker image"
}