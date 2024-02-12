terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.15.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "logical-factor-315804"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "keys.json"
}
