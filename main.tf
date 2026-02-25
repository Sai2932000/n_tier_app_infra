resource "google_compute_network" "vpc" {
  name                    = "tf-vpc"
  auto_create_subnetworks = false

}



resource "google_compute_subnetwork" "web" {
  count         = 3
  name          = var.names[count.index]
  ip_cidr_range = var.subnet_range[count.index]
  region        = var.region
  network       = google_compute_network.vpc.id
  depends_on    = [google_compute_network.vpc]
}
