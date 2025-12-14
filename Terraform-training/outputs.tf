output "db_ip" {
  value = module.database.mysql_ip
}

output "app_ip" {
  value = module.app.flask_ip
}

output "app_port" {
  value = module.app.flask_port
}

output "web_ips" {
  value = module.web.nginx_ips
}

output "web_ports" {
  value = module.web.nginx_ports
}
