resource "google_compute_network" "vpc" {
  name                    = "tf-vpc"
  auto_create_subnetworks = false
}



resource "google_compute_subnetwork" "web" {
  name          = "web-subnet"
  ip_cidr_range = "10.100.1.0/24"
  region        = "asia-south1"
  network       = google_compute_network.vpc.id
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_subnetwork" "app" {
  name          = "app-subnet"
  ip_cidr_range = "10.100.2.0/24"
  region        = "asia-south1"
  network       = google_compute_network.vpc.id
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_subnetwork" "db" {
  name          = "db-subnet"
  ip_cidr_range = "10.100.3.0/24"
  region        = "asia-south1"
  network       = google_compute_network.vpc.id
  depends_on    = [google_compute_network.vpc]
}
