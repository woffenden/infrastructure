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

####

resource "cloudflare_argo_tunnel" "cloudflare_tunnel_demo_bny_woffenden_net" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "cloudflare-tunnel-demo.woffenden.net"
  secret     = "Y2xvdWRmbGFyZV90dW5uZWxfZGVtb19ibnlfd29mZmVuZGVuX25ldF8yNDA2MjAyMg=="
}

resource "cloudflare_record" "woffenden_net_cloudflare_tunnel_demo" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "cloudflare-tunnel-demo"
  type    = "CNAME"
  value   = cloudflare_argo_tunnel.cloudflare_tunnel_demo_bny_woffenden_net.cname
  proxied = true
}