data "google_secret_manager_secret_version" "cloudflare_email" {
  secret = "cloudflare-email"
}

data "google_secret_manager_secret_version" "cloudflare_api_key" {
  secret = "cloudflare-api-key"
}

data "google_secret_manager_secret_version" "cloudflare_account_id" {
  secret = "cloudflare-account-id"
}

data "cloudflare_access_identity_provider" "google_workspace" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "woffenden.io"
}
