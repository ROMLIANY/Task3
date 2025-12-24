# Reference Docker image by digest instead of tag
data "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

# Outputs for nginx digest
output "nginx_digest" {
  value = data.docker_registry_image.nginx.sha256_digest
}