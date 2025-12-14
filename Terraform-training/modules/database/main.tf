terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

resource "docker_volume" "mysql_data" {
  name = "mysql_data"
}

resource "docker_image" "mysql" {
  name         = "mysql:8.0"
  keep_locally = false
}

resource "docker_container" "mysql" {
  name  = "mysql_db"
  image = docker_image.mysql.name

  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_password}",
    "MYSQL_USER=${var.db_user}",
    "MYSQL_PASSWORD=${var.db_password}"
  ]

  networks_advanced {
    name = var.network_name
  }

  volumes {
    volume_name    = docker_volume.mysql_data.name
    container_path = "/var/lib/mysql"
  }
}
