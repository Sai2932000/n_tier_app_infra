
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


