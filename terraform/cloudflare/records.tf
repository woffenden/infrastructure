resource "cloudflare_record" "woffenden_dev_github_pages_challenge" {
  zone_id = module.woffenden_dev_cloudflare_zone.id
  name    = "_github-pages-challenge-woffenden"
  type    = "TXT"
  value   = "3ff9951c0a51b83dca75b05f205366"
}

resource "cloudflare_record" "woffenden_io_github_pages_challenge" {
  zone_id = module.woffenden_io_cloudflare_zone.id
  name    = "_github-pages-challenge-woffenden"
  type    = "TXT"
  value   = "3e8f0954722b4e4341b822e923bf87"
}

resource "cloudflare_record" "woffenden_io_github_organisation_challenge" {
  zone_id = module.woffenden_io_cloudflare_zone.id
  name    = "_github-challenge-woffenden-organization"
  type    = "TXT"
  value   = "7714018f85"
}

resource "cloudflare_record" "woffenden_net_udmp_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "udmp.int.bny"
  type    = "A"
  value   = "10.100.0.1"
}

resource "cloudflare_record" "woffenden_net_nuc01_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "nuc01.int.bny"
  type    = "A"
  value   = "10.100.0.50"
}
