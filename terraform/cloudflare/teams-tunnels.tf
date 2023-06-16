resource "random_password" "bny_woffenden_net_tunnel_secret" {
  length  = 32
  special = false
}

resource "cloudflare_tunnel" "bny_woffenden_net" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "bny.woffenden.net"
  secret     = base64encode(random_password.bny_woffenden_net_tunnel_secret.result)
}

resource "random_password" "paperless_woffenden_family_tunnel_secret" {
  length  = 32
  special = false
}

resource "cloudflare_tunnel" "paperless_woffenden_family" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "paperless.woffenden.family"
  secret     = base64encode(random_password.paperless_woffenden_family_tunnel_secret.result)
}
