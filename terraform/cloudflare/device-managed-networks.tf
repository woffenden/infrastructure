resource "cloudflare_zero_trust_device_managed_networks" "bny_woffenden_net" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "bny.woffenden.net"
  type       = "tls"
  config {
    tls_sockaddr = "managed-network.cloudflare.bny.woffenden.net:443"
    sha256       = "B562DBC547E7F92B681EB03DC7B67D2584AECBE9571A997128FA72C10D717671"
  }
}
