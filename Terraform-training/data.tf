# Reference Docker image by digest instead of tag
data "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

# Outputs for nginx digest
output "nginx_digest" {
  value = data.docker_registry_image.nginx.sha256_digest
}

# Use external data source to query Docker system info on Windows
data "external" "docker_info" {
  program = [
    "powershell",
    "-Command",
    <<EOF
$info = docker info
$os = ($info | Select-String "Operating System" | ForEach-Object { ($_ -split ":")[1].Trim() })
$cpu = ($info | Select-String "CPUs" | ForEach-Object { ($_ -split ":")[1].Trim() })
$mem = ($info | Select-String "Total Memory" | ForEach-Object { ($_ -split ":")[1].Trim() })
$result = @{ OperatingSystem = $os; NCPU = $cpu; Memory = $mem }
$result | ConvertTo-Json -Compress
EOF
  ]
}

output "docker_info" {
  value = data.external.docker_info.result
}

# Optional: separate outputs for convenience
output "docker_os" {
  value = data.external.docker_info.result["OperatingSystem"]
}

output "docker_cpu" {
  value = data.external.docker_info.result["NCPU"]
}

output "docker_mem" {
  value = data.external.docker_info.result["Memory"]
}