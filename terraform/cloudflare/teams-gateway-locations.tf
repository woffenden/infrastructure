resource "cloudflare_teams_location" "cloudflare_warp" {
  account_id     = "af790e83102c7ab5347e7dfbf86ef021"
  name           = "cloudflare-warp.woffenden.net"
  client_default = true
}

resource "cloudflare_teams_location" "bny_woffenden_net" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "bny.woffenden.net"
  networks {
    network = "212.159.121.150/32"
  }
}

resource "cloudflare_teams_location" "actions_github_com" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "container-doh-proxy.jacobwoffenden.actions.github.com"
}