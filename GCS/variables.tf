variable "project_id"          { type = string }
variable "region" {
  type    = string
  default = "asia-east1"
}
variable "gcp_credentials_json" {
  type    = string
  description = "容器內 JSON 內容"
  default = ""
} # 容器內 JSON 內容