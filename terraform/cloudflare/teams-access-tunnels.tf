resource "cloudflare_tunnel_virtual_network" "cloudflare_woffenden_net" {
  account_id         = "af790e83102c7ab5347e7dfbf86ef021"
  name               = "cloudflare.woffenden.net"
  is_default_network = true
}
