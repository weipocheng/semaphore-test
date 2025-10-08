variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-east1"
}

variable "zone" {
  type    = string
  default = "asia-east1-b"
}

variable "name_prefix" {
  type    = string
  default = "test-vm"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "image" {
  description = "Image self link or family, e.g. ubuntu-os-cloud/ubuntu-2204-lts"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "disk_size_gb" {
  type    = number
  default = 60
}

variable "network" {
  description = "VPC network name (use 'default' for the default VPC)"
  type        = string
  default     = "default"
}

variable "tags" {
  type    = list(string)
  default = ["ssh"]
}

variable "ssh_user" {
  type    = string
  default = "ubuntu"
}

variable "ssh_public_key" {
  description = "Public key contents (e.g. from ~/.ssh/id_rsa.pub)"
  type        = string
  default     = ""
}

variable "ssh_source_ranges" {
  description = "CIDR ranges allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "preemptible" {
  type    = bool
  default = false
}

variable "shielded_secure_boot" {
  type    = bool
  default = true
}

variable "metadata" {
  description = "Additional instance metadata to set"
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels to apply to the instance"
  type        = map(string)
  default     = { env = "test" }
}

