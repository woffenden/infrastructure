resource "cloudflare_r2_bucket" "cdn_woffenden_io" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "cdn-woffenden-io"
}

resource "cloudflare_r2_bucket" "paperless_woffenden_family" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "paperless-woffenden-family"
}
