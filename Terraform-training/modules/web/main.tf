terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  count = var.instance_count

  name  = "nginx-${count.index}"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = var.external_port + count.index
  }

  networks_advanced {
    name = var.network_name
  }
}
