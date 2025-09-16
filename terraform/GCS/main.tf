resource "google_storage_bucket" "demo" {
  name     = "${var.project_id}-semaphore-tf-demo"
  location = var.region
  uniform_bucket_level_access = true
}

output "bucket_name" {
  value = google_storage_bucket.demo.name
}