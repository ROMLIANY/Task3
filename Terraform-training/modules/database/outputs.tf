output "mysql_ip" {
  value = docker_container.mysql.network_data[0].ip_address
}
