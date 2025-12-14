output "nginx_ips" {
  value = [for c in docker_container.nginx : c.network_data[0].ip_address]
}

output "nginx_ports" {
  value = [for c in docker_container.nginx : c.ports[0].external]
}
