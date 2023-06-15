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

variable "cloudflare_zone_id" {
  type = string
}
