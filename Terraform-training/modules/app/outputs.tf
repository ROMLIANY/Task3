output "flask_ips" {
  value = var.active_color == "blue" ? [for c in docker_container.flask_blue : c.network_data[0].ip_address] : [for c in docker_container.flask_green : c.network_data[0].ip_address]
}

output "flask_ports" {
  value = var.active_color == "blue" ? [for c in docker_container.flask_blue : c.ports[0].external] : [for c in docker_container.flask_green : c.ports[0].external]
}