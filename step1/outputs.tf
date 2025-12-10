Outputs "container_id" {
    value = docekr_container.nginx.id
} 

output "container_name" {
    value = docker_container.nginx.name
}

output "exposed_port" {
    value - var.external_port
}