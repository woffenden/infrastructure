module "woffenden_net_cloudflare_zone" {
  source = "../modules/cloudflare/zone"
  zone   = "woffenden.net"
}

module "woffenden_net_cloudflare_google_workspace" {
  source                         = "../modules/cloudflare/google-workspace"
  zone_id                        = module.woffenden_net_cloudflare_zone.id
  google_site_verification_token = "IRXN7udPIyqXZ-ttUKN9ctphKU3LRWNB2jiz5DndNtU"
  dkim_record                    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgFLOioELDKu0Y09gAri1K/dw5SvbcPUsS9qoJMly9EC60rxxGHBI6wHPFcCO9DGKk5ZLd5UMM3e/GZIE6pOLBMw29uk/VzexYzKKhVRftoYklqkUKXyDA+OXiUOf70SwtSkBr5XyP6tt8pxWav4a80vcNJn+wKkOz/ZszJRBHyy8TcN8 QeKPl8vLGcHwUN3BDn0mMaB2rrc3Yp6GBkjgCHX3Jt+ND8dOMcyLUYqC7aYZymmQTQBnOr5QKS8/A0IyU55UPygEVQPn3MfYFr5O9P8jVw1cRLDMM6B47RugCP6uAivoo38twF+c6iQQAX/+XmsonSOMTAXKJIZXUfZxRwIDAQAB"
}

resource "cloudflare_record" "woffenden_net_udmp_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "udmp.int.bny"
  type    = "A"
  value   = "10.100.0.1"
}

resource "cloudflare_record" "woffenden_net_usw01_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "usw01.int.bny"
  type    = "A"
  value   = "10.100.0.2"
}

resource "cloudflare_record" "woffenden_net_uap01_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "uap01.int.bny"
  type    = "A"
  value   = "10.100.0.3"
}

resource "cloudflare_record" "woffenden_net_uap02_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "uap02.int.bny"
  type    = "A"
  value   = "10.100.0.4"
}

resource "cloudflare_record" "woffenden_net_cam01_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "cam01.int.bny"
  type    = "A"
  value   = "10.100.0.5"
}

resource "cloudflare_record" "woffenden_net_nuc01_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "nuc01.int.bny"
  type    = "A"
  value   = "10.100.0.50"
}

resource "cloudflare_record" "woffenden_net_pi01_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "pi01.int.bny"
  type    = "A"
  value   = "10.100.10.51"
}

resource "cloudflare_record" "woffenden_net_wifi_guest_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "wifi.guest.bny"
  type    = "A"
  value   = "10.100.108.1"
}

resource "cloudflare_record" "woffenden_net_plusdsl_ext_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "plusdsl.ext.bny"
  type    = "A"
  value   = "212.159.121.150"
}

resource "cloudflare_record" "woffenden_net_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "bny"
  type    = "CNAME"
  value   = cloudflare_record.woffenden_net_plusdsl_ext_bny.hostname
}

resource "cloudflare_record" "woffenden_net_api_kube_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "api.kube.int.bny"
  type    = "CNAME"
  value   = cloudflare_record.woffenden_net_nuc01_int_bny.hostname
}

resource "cloudflare_record" "woffenden_net_ingress_kube_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "ingress.kube.int.bny"
  type    = "A"
  value   = "10.100.0.100"
}