output "flask_ips" {
  value = [
    for c in docker_container.flask :
    c.network_data[0].ip_address
  ]
}

output "flask_ports" {
  value = [
    for i in range(var.instance_count) :
    var.external_port + i
  ]
}

output "flask_sensitive_ips" {
  value     = [for c in docker_container.flask : c.network_data[0].ip_address]
  sensitive = true
}