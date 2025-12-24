output "nginx_ips" {
  value = [for c in docker_container.nginx : c.network_data[0].ip_address]
}

output "nginx_ports" {
  value = [for c in docker_container.nginx : c.ports[0].external]
}

output "nginx_info" {
  description = "JSON with container details"
  value = jsonencode([
    for c in docker_container.nginx : {
      name    = c.name
      ip      = c.network_data[0].ip_address
      ports   = [for p in c.ports : p.external]
      labels  = c.labels
    }
  ])
}

output "nginx_sensitive_ips" {
  description = "Sensitive IP output"
  value       = [for c in docker_container.nginx : c.network_data[0].ip_address]
  sensitive   = true
}