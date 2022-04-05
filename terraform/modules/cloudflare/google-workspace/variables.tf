variable "zone_id" {
  type = string
}

variable "google_site_verification_token" {
  type    = string
  default = "not-required"
}

variable "spf_record" {
  type    = string
  default = "v=spf1 include:_spf.google.com ~all"
}

variable "dmarc_record" {
  type    = string
  default = "v=DMARC1;p=none;rua=mailto:woffenden-d@dmarc.report-uri.com"
}

variable "dkim_record" {
  type = string
}

variable "mta_sts_record" {
  type    = string
  default = "v=STSv1;id=1649124863302;"
}

variable "tlsrpt_record" {
  type    = string
  default = "v=TLSRPTv1;rua=mailto:woffenden-d@tlsrpt.report-uri.com;"
}

locals {
  google_site_verification = "google-site-verification=${var.google_site_verification_token}"
}