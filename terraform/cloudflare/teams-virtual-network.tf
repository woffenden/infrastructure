resource "cloudflare_tunnel_virtual_network" "cloudflare_woffenden_net" {
  account_id         = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name               = "cloudflare.woffenden.net"
  is_default_network = true
}

resource "cloudflare_zero_trust_tunnel_virtual_network" "warp_cloudflare_woffenden_net" {
  account_id         = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name               = "warp.cloudflare.woffenden.net"
  is_default_network = true
}
