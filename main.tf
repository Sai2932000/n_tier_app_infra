resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}



resource "google_compute_subnetwork" "web_subnet" {
  name          = var.web_subnet_name
  ip_cidr_range = var.web_subnet
  region        = var.region
  network       = google_compute_network.vpc.id
}


resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = [
    "0.0.0.0/0",          
    "130.211.0.0/22",     
    "35.191.0.0/16"       
  ]

  target_tags = ["web"]
}


resource "google_compute_instance_template" "web_template" {
  name         = "web-template"
  machine_type = "e2-medium"

  tags = ["web"]

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2204-lts"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.web_subnet.id
    access_config {}
  }

  metadata_startup_script = <<-EOF
#!/bin/bash

# Log everything
exec > /var/log/startup-script.log 2>&1

apt-get update -y
apt-get install -y nginx

echo "Hello from $(hostname)" > /var/www/html/index.html

systemctl daemon-reexec
systemctl enable nginx
systemctl start nginx
EOF
}



resource "google_compute_instance_group_manager" "web_mig" {
  name               = "web-mig"
  base_instance_name = "web"
  zone               = "${var.region}-a"

  version {
    instance_template = google_compute_instance_template.web_template.id
  }

  target_size = 2
}


resource "google_compute_autoscaler" "web_autoscaler" {
  name   = "web-autoscaler"
  zone   = "${var.region}-a"
  target = google_compute_instance_group_manager.web_mig.id

  autoscaling_policy {
    max_replicas = 5
    min_replicas = 2

    cpu_utilization {
      target = 0.6
    }
  }
}



resource "google_compute_health_check" "http_check" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}



resource "google_compute_backend_service" "backend" {
  name     = "web-backend"
  protocol = "HTTP"

  backend {
    group = google_compute_instance_group_manager.web_mig.instance_group
  }

  health_checks = [google_compute_health_check.http_check.id]
}




resource "google_compute_url_map" "url_map" {
  name            = "web-map"
  default_service = google_compute_backend_service.backend.id
}



resource "google_compute_target_http_proxy" "proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.id
}


resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "http-rule"
  target     = google_compute_target_http_proxy.proxy.id
  port_range = "80"
}


output "load_balancer_ip" {
  value = google_compute_global_forwarding_rule.forwarding_rule.ip_address
}
