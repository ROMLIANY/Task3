# Database IP
output "db_ip" {
  value = module.database.mysql_ip
}

# App outputs
output "app_ips" {
  value = module.app.flask_ips
}

output "app_ports" {
  value = module.app.flask_ports
}

# Web outputs
output "web_ips" {
  value = module.web.nginx_ips
}

output "web_ports" {
  value = module.web.nginx_ports
}

# JSON output with all tiers info
output "stack_info" {
  description = "Full stack info in JSON format"
  value = jsonencode({
    database = {
      ip = module.database.mysql_ip
    }
    app = {
      ips   = module.app.flask_ips
      ports = module.app.flask_ports
    }
    web = {
      ips   = module.web.nginx_ips
      ports = module.web.nginx_ports
    }
  })
}

# App ports from locals (moved here from locals.tf)
output "flask_ports" {
  value = local.app_ports
}