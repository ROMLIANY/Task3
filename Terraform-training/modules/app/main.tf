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

resource "docker_container" "flask" {
  name  = "flask_app"
  image = docker_image.flask.name

  env = [
    "DB_HOST=${var.db_host}",
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}"
  ]

  ports {
    internal = 5000
    external = var.external_port
  }

  networks_advanced {
    name = var.network_name
  }

  command = [
    "sh",
    "-c",
    <<EOF
pip install flask mysql-connector-python && python - <<'APP'
from flask import Flask
app = Flask(__name__)

@app.route("/")
def index():
    return "Flask OK"

if __name__ == "__main__":
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
