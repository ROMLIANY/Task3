output "db_host" {
  value = docker_container.mysql.name
}

output "db_name" {
  value = "appdb"
}

output "mysql_ip" {
  description = "Internal IP address of MySQL container"
  value       = docker_container.mysql.network_data[0].ip_address
}