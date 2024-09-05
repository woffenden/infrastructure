resource "cloudflare_record" "google_site_verification" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = local.google_site_verification
}

resource "cloudflare_record" "aspmx" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = "aspmx.l.google.com"
  priority = 1
}

resource "cloudflare_record" "aspmx_alt1" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = "alt1.aspmx.l.google.com"
  priority = 5
}

resource "cloudflare_record" "aspmx_alt2" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = "alt2.aspmx.l.google.com"
  priority = 5
}

resource "cloudflare_record" "aspmx2" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = "aspmx2.googlemail.com"
  priority = 10
}

resource "cloudflare_record" "aspmx3" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = "aspmx3.googlemail.com"
  priority = 10
}

resource "cloudflare_record" "spf" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = var.spf_record
}

resource "cloudflare_record" "dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = var.dmarc_record
}

resource "cloudflare_record" "dkim" {
  zone_id = var.zone_id
  name    = "google._domainkey"
  type    = "TXT"
  content = var.dkim_record
}

resource "cloudflare_record" "mta_sts" {
  zone_id = var.zone_id
  name    = "_mta-sts"
  type    = "TXT"
  content = var.mta_sts_record
}

resource "cloudflare_record" "tlsrpt" {
  zone_id = var.zone_id
  name    = "_smtp._tls"
  type    = "TXT"
  content = var.tlsrpt_record
}
