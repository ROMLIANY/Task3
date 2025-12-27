locals {
  env = terraform.workspace

  network_name = docker_network.app_net.name

  web_count = {
    dev     = 1
    staging = 2
    prod    = 3
  }

  app_count = {
    dev     = 1
    staging = 2
    prod    = 3
  }

  common_labels = {
    managed_by  = "terraform"
    project     = "terraform-training"
    environment = local.env
  }

  web_ports = {
    dev = [
      { internal = 80, external = 8080, protocol = "tcp" }
    ]
    staging = [
      { internal = 80, external = 8080, protocol = "tcp" }
    ]
    prod = [
      { internal = 80, external = 8080, protocol = "tcp" },
      { internal = 443, external = 8443, protocol = "tcp" }
    ]
  }

  app_env_vars = {
    dev = {
      LOG_LEVEL = "debug"
      DEBUG     = "true"
    }
    staging = {
      LOG_LEVEL = "info"
      DEBUG     = "false"
    }
    prod = {
      LOG_LEVEL = "warn"
      DEBUG     = "false"
    }
  }

  # השאר רק את ההגדרה הזו
  app_ports = {
    dev     = [8082, 8083]
    staging = [8082, 8083]
    prod    = [8082, 8083, 8084]
  }

  app_primary_port = {
    dev     = local.app_ports.dev[0]
    staging = local.app_ports.staging[0]
    prod    = local.app_ports.prod[0]
  }
}