resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = [
      "22",
      "80"
    ]
  }

  source_ranges = [
    "0.0.0.0/0",
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]

  target_tags = ["web"]
}