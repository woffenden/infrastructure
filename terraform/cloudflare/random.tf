resource "random_password" "bny_woffenden_net_tunnel_secret" {
  length  = 64
  special = false
}

resource "random_password" "paperless_woffenden_family_tunnel_secret" {
  length  = 32
  special = false
}
