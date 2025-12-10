output "container_ids" {
  value = [for c in docker_container.nginx : c.id]
}

output "container_names" {
  value = [for c in docker_container.nginx : c.name]
}

output "container_ports" {
  value = [for c in docker_container.nginx : c.ports[0].external]
}
