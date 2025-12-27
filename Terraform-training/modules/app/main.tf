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
from flask import Flask
import os
import time
import mysql.connector

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = "appdb"

for i in range(10):
    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        conn.close()
        break
    except Exception:
        time.sleep(3)

app = Flask(__name__)

@app.route("/")
def index():
    return "Flask OK + MySQL Connected"

app.run(host="0.0.0.0", port=5000)
APP
EOF
  ]

  healthcheck {
    test = [
      "CMD-SHELL",
      "python -c \"import urllib.request; urllib.request.urlopen('http://localhost:5000')\""
    ]
    interval = "10s"
    timeout  = "3s"
    retries  = 5
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
    external = var.external_port + count.index + 10   # שינוי כדי לא להתנגש עם blue
  }

  command = [
    "sh",
    "-c",
    <<EOF
pip install flask mysql-connector-python && python - <<APP
from flask import Flask
import os
import time
import mysql.connector

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = "appdb"

for i in range(10):
    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        conn.close()
        break
    except Exception:
        time.sleep(3)

app = Flask(__name__)

@app.route("/")
def index():
    return "Flask OK + MySQL Connected"

app.run(host="0.0.0.0", port=5000)
APP
EOF
  ]

  healthcheck {
    test = [
      "CMD-SHELL",
      "python -c \"import urllib.request; urllib.request.urlopen('http://localhost:5000')\""
    ]
    interval = "10s"
    timeout  = "3s"
    retries  = 5
  }
}