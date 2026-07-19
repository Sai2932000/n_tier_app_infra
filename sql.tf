resource "google_sql_database_instance" "mysql" {

  name             = "mysql-instance"
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {

    tier = "db-f1-micro"

    ip_configuration {

      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id

    }

  }

  deletion_protection = false

  depends_on = [
    google_service_networking_connection.private_connection
  ]

}

resource "google_sql_database" "appdb" {

  name     = var.db_name
  instance = google_sql_database_instance.mysql.name

}

resource "google_sql_user" "appuser" {

  name     = var.db_user
  instance = google_sql_database_instance.mysql.name
  password = var.db_password

}