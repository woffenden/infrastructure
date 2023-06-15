module "woffenden_net_cloudflare_zone" {
  source  = "../modules/cloudflare/zone"
  account = "af790e83102c7ab5347e7dfbf86ef021"
  zone    = "woffenden.net"
}

module "woffenden_net_cloudflare_google_workspace" {
  source                         = "../modules/cloudflare/google-workspace"
  zone_id                        = module.woffenden_net_cloudflare_zone.id
  google_site_verification_token = "IRXN7udPIyqXZ-ttUKN9ctphKU3LRWNB2jiz5DndNtU" # gitleaks-ignore
  dkim_record                    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgFLOioELDKu0Y09gAri1K/dw5SvbcPUsS9qoJMly9EC60rxxGHBI6wHPFcCO9DGKk5ZLd5UMM3e/GZIE6pOLBMw29uk/VzexYzKKhVRftoYklqkUKXyDA+OXiUOf70SwtSkBr5XyP6tt8pxWav4a80vcNJn+wKkOz/ZszJRBHyy8TcN8 QeKPl8vLGcHwUN3BDn0mMaB2rrc3Yp6GBkjgCHX3Jt+ND8dOMcyLUYqC7aYZymmQTQBnOr5QKS8/A0IyU55UPygEVQPn3MfYFr5O9P8jVw1cRLDMM6B47RugCP6uAivoo38twF+c6iQQAX/+XmsonSOMTAXKJIZXUfZxRwIDAQAB"
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
