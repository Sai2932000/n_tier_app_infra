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

  metadata_startup_script = file("${path.module}/startup.sh")
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

