terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

resource "docker_image" "flask" {
  name         = "python:3.11-slim"
  keep_locally = false
}

resource "docker_container" "flask_blue" {
  count = var.active_color == "blue" ? var.instance_count : 0
  name  = "flask_app_blue_${count.index}"
  image = docker_image.flask.name

  env = [
    "DB_HOST=${var.db_host}",
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}"
  ]

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 5000
    external = var.external_port + count.index
  }

  command = [
    "sh",
    "-c",
    <<EOF
pip install flask mysql-connector-python && python - <<APP
# ... קוד Flask ...
APP
EOF
  ]

  healthcheck {
    test     = ["CMD-SHELL", "python -c \"import urllib.request; urllib.request.urlopen('http://localhost:5000')\""]
    interval = "10s"
    timeout  = "3s"
    retries  = 5
  }

  lifecycle {
    precondition {
      condition     = var.instance_count > 0
      error_message = "instance_count חייב להיות גדול מ-0"
    }

    postcondition {
      condition     = self.ports[0].external >= 1024 && self.ports[0].external <= 65535
      error_message = "הפורט חייב להיות בטווח 1024–65535"
    }
  }
}

resource "docker_container" "flask_green" {
  count = var.active_color == "green" ? var.instance_count : 0
  name  = "flask_app_green_${count.index}"
  image = docker_image.flask.name

  env = [
    "DB_HOST=${var.db_host}",
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}"
  ]

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 5000
    external = var.external_port + count.index + 10
  }

command = [
  "sh",
  "-c",
  <<EOF
pip install flask mysql-connector-python &&
python - <<'APP'
from flask import Flask
import os
import mysql.connector
import time

app = Flask(__name__)

@app.route("/")
def index():
    return "Flask app is running!"

app.run(host="0.0.0.0", port=5000)
APP
EOF
]



  healthcheck {
    test     = ["CMD-SHELL", "python -c \"import urllib.request; urllib.request.urlopen('http://localhost:5000')\""]
    interval = "10s"
    timeout  = "3s"
    retries  = 5
  }

  lifecycle {
    precondition {
      condition     = var.instance_count > 0
      error_message = "instance_count חייב להיות גדול מ-0"
    }

    postcondition {
      condition     = self.ports[0].external >= 1024 && self.ports[0].external <= 65535
      error_message = "הפורט חייב להיות בטווח 1024–65535"
    }
  }
}