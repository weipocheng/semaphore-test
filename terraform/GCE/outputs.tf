output "instance_name" {
  value = google_compute_instance.vm.name
}

output "instance_zone" {
  value = google_compute_instance.vm.zone
}

output "internal_ip" {
  value = google_compute_instance.vm.network_interface[0].network_ip
}

output "external_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "ssh_command" {
  description = "SSH command for the VM (prefers external IP if it exists)"
  value = (
    length(google_compute_instance.vm.network_interface[0].access_config) > 0 ?
    "ssh ${var.ssh_user}@${google_compute_instance.vm.network_interface[0].access_config[0].nat_ip}" :
    "ssh ${var.ssh_user}@${google_compute_instance.vm.network_interface[0].network_ip}"
  )
}

