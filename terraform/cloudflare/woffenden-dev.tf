module "woffenden_dev_cloudflare_zone" {
  source  = "../modules/cloudflare/zone"
  account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  zone    = "woffenden.dev"
}

module "woffenden_dev_cloudflare_google_workspace" {
  source      = "../modules/cloudflare/google-workspace"
  zone_id     = module.woffenden_dev_cloudflare_zone.id
  dkim_record = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjOwWiAXcflA/UB0IwKnLLhXH/CsDjDyPBCYj2roopdZ3dI+pR4Z9qBQ8EYbcO7U96hV0qCyLGsmfQq2jVWPtZWf9PamXyxES1nXN3WDQOUtbbprvGXsoNbgtr2Iba3yY1uE0301KVn7WS8/m5PFpNehNQjflmB2yB2pimUkwJaLGnB/n2I3jvG4I3QOm6egk jRTYVFi04QupOu/BRXWpfXmYUFr21g89M5BSurKZsbLoc9XZv+/meNlewO0PuCvWOZ5wz0u5eoKDJXKOy/mBkyQjvbfaES45tqOfXNYEnE/cqNpuzmDHJ5zAmRAiQGVgkMoXXdUwNK9mcj4RB+77GQIDAQAB"
}

resource "cloudflare_record" "woffenden_dev_github_pages_challenge" {
  zone_id = module.woffenden_dev_cloudflare_zone.id
  name    = "_github-pages-challenge-woffenden"
  type    = "TXT"
  value   = "3ff9951c0a51b83dca75b05f205366"
}
