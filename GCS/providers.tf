provider "google" {
  project = var.project_id
  region  = var.region
  credentials = var.gcp_credentials_path != "" ? file(var.gcp_credentials_path) : null
}