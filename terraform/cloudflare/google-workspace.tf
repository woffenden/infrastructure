module "grigorieva_io_cloudflare_google_workspace" {
  source = "../modules/cloudflare/google-workspace"

  zone_id                        = module.grigorieva_io_cloudflare_zone.id
  google_site_verification_token = "waQ2GJGY5BTnqHnXIT8boFAQML5Fqy4tQ6KPPj7KtZk" # gitleaks-ignore
  dkim_record                    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgFLOioELDKu0Y09gAri1K/dw5SvbcPUsS9qoJMly9EC60rxxGHBI6wHPFcCO9DGKk5ZLd5UMM3e/GZIE6pOLBMw29uk/VzexYzKKhVRftoYklqkUKXyDA+OXiUOf70SwtSkBr5XyP6tt8pxWav4a80vcNJn+wKkOz/ZszJRBHyy8TcN8 QeKPl8vLGcHwUN3BDn0mMaB2rrc3Yp6GBkjgCHX3Jt+ND8dOMcyLUYqC7aYZymmQTQBnOr5QKS8/A0IyU55UPygEVQPn3MfYFr5O9P8jVw1cRLDMM6B47RugCP6uAivoo38twF+c6iQQAX/+XmsonSOMTAXKJIZXUfZxRwIDAQAB"
}

module "woffenden_dev_cloudflare_google_workspace" {
  source = "../modules/cloudflare/google-workspace"

  zone_id     = module.woffenden_dev_cloudflare_zone.id
  dkim_record = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjOwWiAXcflA/UB0IwKnLLhXH/CsDjDyPBCYj2roopdZ3dI+pR4Z9qBQ8EYbcO7U96hV0qCyLGsmfQq2jVWPtZWf9PamXyxES1nXN3WDQOUtbbprvGXsoNbgtr2Iba3yY1uE0301KVn7WS8/m5PFpNehNQjflmB2yB2pimUkwJaLGnB/n2I3jvG4I3QOm6egk jRTYVFi04QupOu/BRXWpfXmYUFr21g89M5BSurKZsbLoc9XZv+/meNlewO0PuCvWOZ5wz0u5eoKDJXKOy/mBkyQjvbfaES45tqOfXNYEnE/cqNpuzmDHJ5zAmRAiQGVgkMoXXdUwNK9mcj4RB+77GQIDAQAB"
}

module "woffenden_io_cloudflare_google_workspace" {
  source = "../modules/cloudflare/google-workspace"

  zone_id                        = module.woffenden_io_cloudflare_zone.id
  google_site_verification_token = "799M9quOWQxm3RQycRgG2rrrGw2tPz903gfFRPUonZ8" # gitleaks-ignore
  dkim_record                    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApz9L6PdDZNFE1H7/B1WvVlvAVrqaww9omVjerX6wGib6q+lrVG4P7AG5pCXrBuW+C/SHyYukArMOg+F4xSEhsEx9HO7yRTHkTeYz6GzE0SITHVu4GZJc1bodwZXFSfJ5/pNnChxGfVWAGKv8UDP+SCjc+yxQhE/wcLg3L1mZImwCLz4vVe1NKl7RyvrG5u/g0Z4Auds5P6ed+4a3Ze5mEyZ+kYS/p14sXURAFVutPoAIZFERoaRug6pzRgya1R0QHZsngkMF2FT7ZZHU1meF65PQjIvZvUVf/nzl0cECwSaebC+NwYBYq6DYbhRjyVBydNVRi2LPgU4wkr3isysoZwIDAQAB"
}

module "woffenden_net_cloudflare_google_workspace" {
  source = "../modules/cloudflare/google-workspace"

  zone_id                        = module.woffenden_net_cloudflare_zone.id
  google_site_verification_token = "IRXN7udPIyqXZ-ttUKN9ctphKU3LRWNB2jiz5DndNtU" # gitleaks-ignore
  dkim_record                    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgFLOioELDKu0Y09gAri1K/dw5SvbcPUsS9qoJMly9EC60rxxGHBI6wHPFcCO9DGKk5ZLd5UMM3e/GZIE6pOLBMw29uk/VzexYzKKhVRftoYklqkUKXyDA+OXiUOf70SwtSkBr5XyP6tt8pxWav4a80vcNJn+wKkOz/ZszJRBHyy8TcN8 QeKPl8vLGcHwUN3BDn0mMaB2rrc3Yp6GBkjgCHX3Jt+ND8dOMcyLUYqC7aYZymmQTQBnOr5QKS8/A0IyU55UPygEVQPn3MfYFr5O9P8jVw1cRLDMM6B47RugCP6uAivoo38twF+c6iQQAX/+XmsonSOMTAXKJIZXUfZxRwIDAQAB"
}

module "woffendens_co_uk_cloudflare_google_workspace" {
  source = "../modules/cloudflare/google-workspace"

  zone_id     = module.woffendens_co_uk_cloudflare_zone.id
  dkim_record = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCm+5fecbzikY2EuSXS7G5FPfISZtwfnFG9RPpvS13fIEDKjwwYQ4dDUhFaKsFFsoRb6dF1RpVZqvF/DtfD+qXw4ZMifzLilSWLSPr3Ir5bw75dgKoBHK7i+W7qPvRlr/BWGFc8lX8z68TRVa2xBf6JCe9C5+TZbedxfwUOCEz3KwIDAQAB"
}
