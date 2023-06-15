module "woffendens_co_uk_cloudflare_zone" {
  source  = "../modules/cloudflare/zone"
  account = "af790e83102c7ab5347e7dfbf86ef021"
  zone    = "woffendens.co.uk"
}

module "woffendens_co_uk_cloudflare_google_workspace" {
  source      = "../modules/cloudflare/google-workspace"
  zone_id     = module.woffendens_co_uk_cloudflare_zone.id
  dkim_record = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCm+5fecbzikY2EuSXS7G5FPfISZtwfnFG9RPpvS13fIEDKjwwYQ4dDUhFaKsFFsoRb6dF1RpVZqvF/DtfD+qXw4ZMifzLilSWLSPr3Ir5bw75dgKoBHK7i+W7qPvRlr/BWGFc8lX8z68TRVa2xBf6JCe9C5+TZbedxfwUOCEz3KwIDAQAB"
}
