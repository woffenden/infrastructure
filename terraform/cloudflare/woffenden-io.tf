module "woffenden_io_cloudflare_zone" {
  source = "../modules/cloudflare/zone"
  account = "af790e83102c7ab5347e7dfbf86ef021"
  zone   = "woffenden.io"
}

module "woffenden_io_cloudflare_google_workspace" {
  source                         = "../modules/cloudflare/google-workspace"
  zone_id                        = module.woffenden_io_cloudflare_zone.id
  google_site_verification_token = "799M9quOWQxm3RQycRgG2rrrGw2tPz903gfFRPUonZ8"
  dkim_record                    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApz9L6PdDZNFE1H7/B1WvVlvAVrqaww9omVjerX6wGib6q+lrVG4P7AG5pCXrBuW+C/SHyYukArMOg+F4xSEhsEx9HO7yRTHkTeYz6GzE0SITHVu4GZJc1bodwZXFSfJ5/pNnChxGfVWAGKv8UDP+SCjc+yxQhE/wcLg3L1mZImwCLz4vVe1NKl7RyvrG5u/g0Z4Auds5P6ed+4a3Ze5mEyZ+kYS/p14sXURAFVutPoAIZFERoaRug6pzRgya1R0QHZsngkMF2FT7ZZHU1meF65PQjIvZvUVf/nzl0cECwSaebC+NwYBYq6DYbhRjyVBydNVRi2LPgU4wkr3isysoZwIDAQAB"
}

resource "cloudflare_record" "woffenden_io_home" {
  zone_id = module.woffenden_io_cloudflare_zone.id
  name    = "home"
  type    = "CNAME"
  value   = cloudflare_record.woffenden_net_bny.hostname
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
