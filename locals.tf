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
}