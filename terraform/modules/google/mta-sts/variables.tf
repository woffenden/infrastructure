variable "domain" {
  type = string
}

variable "location" {
  type    = string
  default = "EUROPE-WEST2"
}

variable "storage_class" {
  type    = string
  default = "STANDARD"
}

variable "uniform_bucket_level_access" {
  type    = bool
  default = true
}

variable "cloudflare_zone_id" {
  type = string
}

locals {
  gcs_bucket_name = "mta-sts.${var.domain}"
}