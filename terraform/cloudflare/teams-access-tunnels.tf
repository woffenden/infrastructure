resource "cloudflare_tunnel_virtual_network" "cloudflare_woffenden_net" {
  account_id         = "af790e83102c7ab5347e7dfbf86ef021"
  name               = "cloudflare.woffenden.net"
  is_default_network = true
}

####

resource "cloudflare_argo_tunnel" "bny_woffenden_net" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "bny.woffenden.net"
  secret     = "Ym55X3dvZmZlbmRlbl9uZXRfMjQwNjIwMjI="
}

resource "cloudflare_tunnel_route" "bny_woffenden_net" {
  account_id         = "af790e83102c7ab5347e7dfbf86ef021"
  tunnel_id          = cloudflare_argo_tunnel.bny_woffenden_net.id
  network            = "10.100.0.0/24"
  virtual_network_id = cloudflare_tunnel_virtual_network.cloudflare_woffenden_net.id
}
