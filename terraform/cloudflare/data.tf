data "google_secret_manager_secret_version" "cloudflare_email" {
 secret = "cloudflare-email"
}

data "google_secret_manager_secret_version" "cloudflare_api_key" {
 secret = "cloudflare-api-key"
}
