resource "cloudflare_zero_trust_device_managed_networks" "bny_woffenden_net" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "bny.woffenden.net"
  type       = "tls"
  config {
    tls_sockaddr = "managed-network.cloudflare.bny.woffenden.net:443"
    sha256       = "59860E240B1C62E87A8E27418F71E8F7445DCBCBFAA63E6F1F03E56365C5DC49"
  }
}
