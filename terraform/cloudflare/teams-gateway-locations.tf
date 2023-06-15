resource "cloudflare_teams_location" "cloudflare_warp" {
  account_id     = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name           = "cloudflare-warp.woffenden.net"
  client_default = true
}
