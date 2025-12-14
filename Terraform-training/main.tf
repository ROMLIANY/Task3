terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

provider "docker" {}

resource "docker_network" "app_net" {
  name = var.network_name
}

module "database" {
  source       = "./modules/database"
  db_user      = var.db_user
  db_password  = var.db_password
  network_name = docker_network.app_net.name
}

module "app" {
  source        = "./modules/app"
  network_name  = docker_network.app_net.name
  external_port = var.external_port

  db_host     = module.database.mysql_ip
  db_user     = var.db_user
  db_password = var.db_password

  depends_on = [module.database]
}

module "web" {
  source         = "./modules/web"
  network_name   = docker_network.app_net.name
  instance_count = var.instance_count
  external_port  = var.external_port_web

  depends_on = [module.app]
}