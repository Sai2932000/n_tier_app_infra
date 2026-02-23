terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "carbide-program-466301-h4"
  region  = "asia-south1"
}
