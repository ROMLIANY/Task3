output "flask_ip" {
  value = docker_container.flask.network_data[0].ip_address
}

output "flask_port" {
  value = 5000
}
