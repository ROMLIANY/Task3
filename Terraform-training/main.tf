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
  network_name = local.network_name
}

module "app" {
  source         = "./modules/app"
  network_name   = local.network_name
  external_port  = var.external_port
  instance_count = local.app_count[local.env]

  db_host     = module.database.mysql_ip
  db_user     = var.db_user
  db_password = var.db_password

  env_vars = local.app_env_vars[local.env]

  depends_on = [module.database]
}

module "web" {
  source         = "git::https://github.com/ROMLIANY/terraform-web-module.git?ref=v1.0.0"


  network_name   = local.network_name
  instance_count = local.web_count[local.env]
  ports          = local.web_ports[local.env]

  labels = merge(
    local.common_labels,
    { tier = "web" }
  )

  depends_on = [module.app]
}