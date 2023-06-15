module "grigorieva_io_cloudflare_zone" {
  source  = "../modules/cloudflare/zone"

  account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  zone    = "grigorieva.io"
}

module "grigorieva_io_cloudflare_google_workspace" {
  source                         = "../modules/cloudflare/google-workspace"
  zone_id                        = module.grigorieva_io_cloudflare_zone.id
  google_site_verification_token = "waQ2GJGY5BTnqHnXIT8boFAQML5Fqy4tQ6KPPj7KtZk" # gitleaks-ignore
  dkim_record                    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgFLOioELDKu0Y09gAri1K/dw5SvbcPUsS9qoJMly9EC60rxxGHBI6wHPFcCO9DGKk5ZLd5UMM3e/GZIE6pOLBMw29uk/VzexYzKKhVRftoYklqkUKXyDA+OXiUOf70SwtSkBr5XyP6tt8pxWav4a80vcNJn+wKkOz/ZszJRBHyy8TcN8 QeKPl8vLGcHwUN3BDn0mMaB2rrc3Yp6GBkjgCHX3Jt+ND8dOMcyLUYqC7aYZymmQTQBnOr5QKS8/A0IyU55UPygEVQPn3MfYFr5O9P8jVw1cRLDMM6B47RugCP6uAivoo38twF+c6iQQAX/+XmsonSOMTAXKJIZXUfZxRwIDAQAB"
}
