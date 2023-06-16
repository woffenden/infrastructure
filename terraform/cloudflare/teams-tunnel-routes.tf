resource "cloudflare_tunnel_route" "int_bny_woffenden_net" {
  account_id         = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  tunnel_id          = cloudflare_tunnel.bny_woffenden_net.id
  network            = "10.100.0.0/24"
  comment            = "int.bny.woffenden.net"
  virtual_network_id = cloudflare_tunnel_virtual_network.cloudflare_woffenden_net.id
}
