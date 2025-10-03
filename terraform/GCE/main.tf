resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  base_name       = "${var.name_prefix}-${random_id.suffix.hex}"
  ssh_metadata    = var.ssh_public_key != "" ? { "ssh-keys" = "${var.ssh_user}:${var.ssh_public_key}" } : {}
  merged_metadata = merge(local.ssh_metadata, var.metadata)
}

resource "google_compute_instance" "vm" {
  name         = local.base_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags
  labels       = var.labels

  boot_disk {
    auto_delete = true

    initialize_params {
      image = var.image
      size  = var.disk_size_gb
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = var.network
    # Ephemeral external IP for quick SSH testing
    access_config {}
  }

  scheduling {
    preemptible        = var.preemptible
    provisioning_model = var.preemptible ? "SPOT" : "STANDARD"
    automatic_restart  = var.preemptible ? false : true
  }

  shielded_instance_config {
    enable_secure_boot          = var.shielded_secure_boot
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata = local.merged_metadata
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${local.base_name}-allow-ssh"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = var.tags
  description   = "Allow SSH to ${local.base_name}"
}

