terraform {
  backend "gcs" {
    prefix = "google-cloud-opentofu-backend"
  }
}
