resource "google_compute_network" "vpc" {
  name                    = "tf-vpc"
  auto_create_subnetworks = false

}



resource "google_compute_subnetwork" "web" {
  name          = var.web_subnet_name
  ip_cidr_range = var.web_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc.id
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_subnetwork" "app" {
  name          = var.app_subnet_name
  ip_cidr_range = var.app_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc.id
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_subnetwork" "db" {
  name          = var.db_subnet_name
  ip_cidr_range = var.db_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc.id
  depends_on    = [google_compute_network.vpc]
}
