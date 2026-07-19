output "load_balancer_ip" {
  value = google_compute_global_forwarding_rule.forwarding_rule.ip_address
}

output "cloud_sql_private_ip" {
  value = google_sql_database_instance.mysql.private_ip_address
}

output "database_name" {
  value = google_sql_database.appdb.name
}

output "database_user" {
  value = google_sql_user.appuser.name
}