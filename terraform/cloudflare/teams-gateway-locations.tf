resource "cloudflare_teams_location" "warp_cloudflare_woffenden_net" {
  account_id     = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name           = "warp.cloudflare.woffenden.net"
  client_default = true
}

resource "cloudflare_teams_location" "bny_woffenden_net" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "bny.woffenden.net"
}
