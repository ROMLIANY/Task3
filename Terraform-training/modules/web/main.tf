resource "docker_image" "nginx" {
  name = "nginx:${var.image_tag}"
}

resource "docker_container" "nginx" {
  count = var.instance_count

  name  = "${var.container_name}-${count.index + 1}"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 80
    external = var.external_port + count.index
  }
}
