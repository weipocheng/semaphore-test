variable "project_id"          { type = string }
variable "region" {
  type    = string
  default = "asia-east1"
}
variable "gcp_credentials_path" {
  type    = string
  description = "容器內 JSON 路徑"
  default = ""
} # 容器內 JSON 路徑