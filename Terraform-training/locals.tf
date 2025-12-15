locals {
  env = terraform.workspace

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

  db_count = {
    dev     = 1
    staging = 1
    prod    = 1
  }

  common_labels  = {
    managed_by   = "terraform"
    project      = "terraform-training"
    environment  = local.env
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
}