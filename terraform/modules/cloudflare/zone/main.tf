resource "cloudflare_zone" "this" {
  zone       = var.zone
  plan       = var.plan
  type       = var.type
  paused     = var.paused
  jump_start = var.jump_start
}

resource "cloudflare_zone_dnssec" "this" {
  zone_id = cloudflare_zone.this.id
}

resource "cloudflare_zone_settings_override" "this" {
  zone_id = cloudflare_zone.this.id

  settings {
    always_online               = "on"
    always_use_https            = "on"
    automatic_https_rewrites    = "on"
    binary_ast                  = "off"
    brotli                      = "on"
    browser_cache_ttl           = 14400
    browser_check               = "on"
    cache_level                 = "aggressive"
    challenge_ttl               = 1800
    development_mode            = "off"
    email_obfuscation           = "on"
    hotlink_protection          = "on"
    http3                       = "on"
    ip_geolocation              = "on"
    ipv6                        = "on"
    max_upload                  = 100
    min_tls_version             = "1.2"
    opportunistic_encryption    = "on"
    opportunistic_onion         = "on"
    privacy_pass                = "on"
    pseudo_ipv4                 = "off"
    rocket_loader               = "off"
    security_level              = "medium"
    server_side_exclude         = "on"
    ssl                         = "strict"
    tls_1_3                     = "zrt"
    tls_client_auth             = "off"
    universal_ssl               = "on"
    websockets                  = "on"
    zero_rtt                    = "on"

    minify {
      css  = "on"
      html = "off"
      js   = "on"
    }

    security_header {
      enabled            = false
      include_subdomains = false
      max_age            = 0
      nosniff            = false
      preload            = false
    }
  }
}
