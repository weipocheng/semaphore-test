# GCE Test VM (Terraform)

Provision a minimal Google Compute Engine VM for testing.

## Prerequisites
- Terraform >= 1.3
- Google Cloud project with billing enabled
- Auth set up via one of:
  - `gcloud auth application-default login`, or
  - `GOOGLE_APPLICATION_CREDENTIALS` pointing to a service account JSON key

## Files
- `providers.tf` — Google provider config
- `variables.tf` — Inputs with sensible defaults
- `main.tf` — VM instance and SSH firewall rule
- `outputs.tf` — Useful outputs (external IP, ssh command)
- `versions.tf` — Pinned provider versions

## Quick start
```bash
cd terraform/GCE
terraform init
terraform apply \
  -var "project_id=<YOUR_GCP_PROJECT_ID>" \
  -var "ssh_public_key=$(cat ~/.ssh/id_rsa.pub)" \
  -auto-approve
```

## Common variables
- `project_id` (required): Your GCP project ID
- `region` (default: `asia-east1`)
- `zone` (default: `asia-east1-b`)
- `name_prefix` (default: `test-vm`)
- `machine_type` (default: `e2-micro`)
- `image` (default: `ubuntu-os-cloud/ubuntu-2204-lts`)
- `disk_size_gb` (default: `20`)
- `network` (default: `default`)
- `ssh_public_key`: Contents of your public key (enables SSH metadata)
- `ssh_user` (default: `ubuntu`)
- `ssh_source_ranges` (default: `["0.0.0.0/0"]`) — restrict for security

## Notes
- Creates a firewall rule allowing SSH (tcp/22) to instances with the tag in `tags` (default includes `ssh`).
- Attaches an ephemeral external IP for quick access; remove `access_config {}` to make it internal-only.
- For cheapest spot/preemptible VM, set `-var preemptible=true`.
```
ssh ${var.ssh_user}@$(terraform output -raw external_ip)
```

## Destroy
```bash
terraform destroy -auto-approve
```
